# MPSoundEngine
[![Version](http://cocoapod-badges.herokuapp.com/v/MPSoundEngine/badge.png)](http://cocoadocs.org/docsets/MPSoundEngine)
[![Platform](http://cocoapod-badges.herokuapp.com/p/MPSoundEngine/badge.png)](http://cocoadocs.org/docsets/MPSoundEngine)

`MPSoundEngine` allows you to very easily synthesise sounds for mono or stereo output on OS X.

## Usage
`MPSoundEngine` is designed to be as easily usable as possible. There are two concrete subclasses,
`MPMonoSoundEngine` and `MPStereoSoundEngine`. You interact with them through `MPSoundChannel` objects.

This project also includes an example. To run the example project; clone the repo, and run `pod install` from the Example directory first.

### Mono Sound
Here's how to synthesise the musical note A as a mono signal.

    MPMonoSoundEngine *engine = [[MPMonoSoundEngine alloc] init];
    engine.channel.frequency = 440.0; // 440 Hz is the musical note A
    [engine start];

### Stereo Sound
Here's how to synthesise the musical note A on the left channel and the musical note C on the right channel as a stereo signal.

    MPStereoSoundEngine *engine = [[MPStereoSoundEngine alloc] init];
    engine.leftChannel.frequency = 440.0; // 440 Hz is the musical note A
    engine.rightChannel.frequency = 261.00; // 261 Hz is the musical note C
    [engine start];

## Installation
MPSoundEngine is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "MPSoundEngine"

## Author
Matthias Plappert, matthiasplappert@me.com

## Acknowledgments
This code is partly based on an example provided by Alex Chaffee on [stackoverflow](http://stackoverflow.com/questions/2067267/where-to-start-with-audio-synthesis-on-iphone/2067987#2067987).

## License
MPSoundEngine is available under the MIT license. See the LICENSE file for more info.
