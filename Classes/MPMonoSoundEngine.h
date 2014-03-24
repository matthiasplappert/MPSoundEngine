//
//  MPMonoSoundEngine.h
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
#import <MPSoundEngine/MPSoundEngine.h>
#import <MPSoundEngine/MPSoundChannel.h>

/**
 * `MPMonoSoundEngine` is a subclass of `MPSoundEngine` that can be used
 * to generate sounds for a single channel.
 */
@interface MPMonoSoundEngine : MPSoundEngine

/**
 * Initializes a `MPMonoSoundEngine` object with a default sample rate of `44100.0`.
 * 
 * @return The newly-initialized sound engine
 */
- (id)init;

/**
 * Initializes the `MPMonoSoundEngine` with the given sample rate.
 *
 * @note This is the designated initializer of the `MPMonoSoundEngine` class.
 * 
 * @param sampleRate The sample rate used by the engine to construct the signal.
 * @return The newly-initialized sound engine
 */
- (id)initWithSampleRate:(double)sampleRate;

/// The single channel of the sound engine.
@property (strong, readonly) MPSoundChannel *channel;

@end
