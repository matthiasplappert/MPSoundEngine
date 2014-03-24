//
//  MPSoundChannel.h
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

/**
 * `MPSoundChannel` contains information associated with an output channel.
 * 
 * In most cases, you will only adjust the `volume` and `frequency` properties.
 * You can use the `phase` property of the channel to visualize the frequency.
 * An `MPSoundEngine` object uses this information to calculate the audio signal
 * for the given channel.
 */
@interface MPSoundChannel : NSObject

/**
 * The frequency of the channel in Hertz.
 *
 * Defaults to `440.0`, which is the musicle note A.
 */
@property (assign) double frequency;

/**
 * The volume of the channel.
 * 
 * Must be a value between `0.0` and `1.0`, where `1.0` is loudest. Defaults
 * to `0.5`.
 */
@property (assign) double volume;

/**
 * The current phase of the sine wave.
 *
 * Defaults to `0.0`.
 */
@property (assign) double phase;

@end
