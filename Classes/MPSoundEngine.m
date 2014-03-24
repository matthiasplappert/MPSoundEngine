//
//  MPSoundEngine.m
//  MPSoundEngine
//
//  Copyright (c) 2014 Matthias Plappert <matthiasplappert@me.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "MPSoundEngine.h"
#import "MPSoundChannel.h"

static UInt32 MPSoundEngineSizeInFrames = 512;
static UInt32 MPSoundEngineNumBuffers = 4;

void queueCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer);

@interface MPSoundEngine () {
    AudioStreamBasicDescription _streamDescription;
    AudioQueueRef _audioQueue;
    AudioQueueBufferRef *_queueBuffers;
}

@property (nonatomic, assign, readwrite, getter = isRunning) BOOL running;

@end

@implementation MPSoundEngine

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithSampleRate:(double)sampleRate numberOfChannels:(NSUInteger)numberOfChannels {
    if ((self = [super init])) {
        // Default values.
        _sampleRate = sampleRate;
        _numberOfChannels = numberOfChannels;
        _running = NO;
        
        // Create channels.
        NSMutableArray *channels = [NSMutableArray arrayWithCapacity:numberOfChannels];
        for (NSUInteger i = 0; i < numberOfChannels; i++) {
            MPSoundChannel *channel = [[MPSoundChannel alloc] init];
            [channels addObject:channel];
        }
        _channels = [channels copy];
        
        // Configure stream description.
        _streamDescription.mSampleRate = sampleRate;
        _streamDescription.mFormatID = kAudioFormatLinearPCM;
        _streamDescription.mFormatFlags = (kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked);
        _streamDescription.mFramesPerPacket = 1;
        _streamDescription.mChannelsPerFrame = (UInt32)numberOfChannels;
        _streamDescription.mBytesPerPacket = (UInt32)(sizeof(UInt16) * self.numberOfChannels);
        _streamDescription.mBytesPerFrame = _streamDescription.mBytesPerPacket;
        _streamDescription.mBitsPerChannel = 16;
        
        // Create audio queue.
        OSStatus result = AudioQueueNewOutput(&_streamDescription,
                                              queueCallback,
                                              (__bridge void *)(self),
                                              NULL,
                                              NULL,
                                              0,
                                              &_audioQueue
                                              );
        NSAssert(result == noErr, @"Could not create audio queue");
        
        // Allocate buffers for the audio.
        UInt32 bufferSizeBytes = MPSoundEngineSizeInFrames * _streamDescription.mBytesPerFrame;
        _queueBuffers = malloc(sizeof(AudioQueueBufferRef) * MPSoundEngineNumBuffers);
        for (int i = 0; i < MPSoundEngineNumBuffers; i++) {
            OSStatus result = AudioQueueAllocateBuffer(_audioQueue, bufferSizeBytes, &_queueBuffers[i]);
            NSAssert(result == noErr, @"Could not allocate queue buffer");
            
            // Prime the buffers.
            queueCallback((__bridge void *)(self), _audioQueue, _queueBuffers[i]);
        }
    }
    return self;
}

- (void)dealloc {
    if (_audioQueue) {
        AudioQueueStop(_audioQueue, true);
        AudioQueueDispose(_audioQueue, YES);
    }
    if (_queueBuffers) free(_queueBuffers);
}

#pragma mark - Actions

- (void)start {
    if (self.running) {
        return;
    }
    
    OSStatus result = AudioQueueSetParameter(_audioQueue, kAudioQueueParam_Volume, 1.0);
    NSAssert(result == noErr, @"Could not set audio queue parameter");
    
    // Start the queue.
    result = AudioQueueStart(_audioQueue, NULL);
    NSAssert(result == noErr, @"Could not start the audio queue");
    self.running = YES;
}

- (void)stop {
    if (!self.running) {
        return;
    }
    
    OSStatus result = AudioQueuePause(_audioQueue);
    NSAssert(result == noErr, @"Could not stop the audio queue");
    self.running = NO;
}

#pragma mark - Private Methods

- (void)mp_generateSoundWithQueue:(AudioQueueRef)audioQueue buffer:(AudioQueueBufferRef)buffer {
    // Render the wave
    
    // AudioQueueBufferRef is considered "opaque", but it's a reference to
    // an AudioQueueBuffer which is not.
    // All the samples manipulate this, so I'm not quite sure what they mean by opaque
    // saying....
    SInt16 *coreAudioBuffer = (SInt16 *)buffer->mAudioData;
    
    // Specify how many bytes we're providing
    buffer->mAudioDataByteSize = MPSoundEngineSizeInFrames * _streamDescription.mBytesPerFrame;
    
    for (int s = 0; s < MPSoundEngineSizeInFrames * self.numberOfChannels; s += self.numberOfChannels) {
        for (NSUInteger i = 0; i < [self.channels count]; i++) {
            MPSoundChannel *channel = self.channels[i];
            
            float volume = channel.volume;
            float step   = 2 * M_PI * channel.frequency / self.sampleRate;
            
            float sample = (volume * sinf(channel.phase));
            short sampleI = (int)(sample * 32767.0);
            
            coreAudioBuffer[s + i] = sampleI;
            channel.phase += step;
        }
    }
    
    for (MPSoundChannel *channel in self.channels) {
        // Take modulus to preserve precision.
        channel.phase = fmodf(channel.phase, 2 * M_PI);
    }
    
    // Enqueue the buffer
    AudioQueueEnqueueBuffer(audioQueue, buffer, 0, NULL);
}

@end

void queueCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer) {
    MPSoundEngine *soundEngine = (__bridge MPSoundEngine *)inUserData;
    NSCAssert(soundEngine, @"Invalid sound engine reference");
    [soundEngine mp_generateSoundWithQueue:inAQ buffer:inBuffer];
}
