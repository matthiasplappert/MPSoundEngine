//
//  MPSoundEngine.h
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

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MPSoundEngine/MPSoundChannel.h>

/**
 * `MPSoundEngine` is an abstract class that allows to generate sound output for
 * a given number of channels with a given sample rate.
 *
 * @note You will usyally use one of the subclasses `MPMonoSoundEngine` or
 * `MPStereoSoundEngine`.
 */
@interface MPSoundEngine : NSObject

/**
 * Initializes the `MPSoundEngine` with the given sample rate and number of channels.
 *
 * @note This is the designated initializer of the `MPSoundEngine` class.
 * 
 * @param sampleRate The sample rate used by the engine to construct the signal.
 * @param numberOfChannels The number of output channels that the sound engine should use.
 * @return The newly-initialized sound engine
 */
- (id)initWithSampleRate:(double)sampleRate numberOfChannels:(NSUInteger)numberOfChannels;

/// The sample rate of the sound engine.
@property (assign, readonly) double sampleRate;

/// The number of channels the sound engine uses.
@property (assign, readonly) NSUInteger numberOfChannels;

/*
 * All channels of the sound engine.
 *
 * The length of the array is equal to `numberOfChannels`. Every item in the
 * array is a `MPSoundChannel` object.
 */
@property (copy, readonly) NSArray *channels;

/// @name State

/// Indicates if the engine is currently running.
@property (assign, readonly, getter = isRunning) BOOL running;

/**
 * Starts the sound engine.
 *
 * @note If the sound engine is already running, this method has no effect.
 */
- (void)start;

/**
 * Stops the sound engine.
 *
 * @note If the sound engine is not running, this method has no effect.
 */
- (void)stop;

@end
