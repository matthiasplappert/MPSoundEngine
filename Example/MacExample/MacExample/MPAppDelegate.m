//
//  MPAppDelegate.m
//  MacExample
//
//  Created by Matthias Plappert on 24/03/14.
//  Copyright (c) 2014 Matthias Plappert. All rights reserved.
//

#import "MPAppDelegate.h"

@interface MPAppDelegate ()

@property (strong) MPStereoSoundEngine *soundEngine;

@end

@implementation MPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Configure sound engine.
    self.soundEngine = [[MPStereoSoundEngine alloc] init];
    self.soundEngine.leftChannel.frequency = 440.0;
    self.soundEngine.leftChannel.volume = 0.5;
    self.soundEngine.rightChannel.frequency = 440.0;
    self.soundEngine.rightChannel.volume = 0.5;
    
    self.leftChannelFrequencySlider.doubleValue = self.soundEngine.leftChannel.frequency;
    self.rightChannelFrequencyLabel.doubleValue = self.soundEngine.rightChannel.frequency;
    [self updateLeftFrequencyLabel];
    [self updateRightFrequencyLabel];
    [self updateButton];
}

#pragma mark - Actions

- (IBAction)startStop:(id)sender {
    if (self.soundEngine.running) {
        [self.soundEngine stop];
    } else {
        [self.soundEngine start];
    }
    [self updateButton];
}

- (IBAction)leftChannelFrequencySliderDidChange:(NSSlider *)sender {
    self.soundEngine.leftChannel.frequency = sender.doubleValue;
    [self updateLeftFrequencyLabel];
}

- (IBAction)rightChannelFrequencySliderDidChange:(NSSlider *)sender {
    self.soundEngine.rightChannel.frequency = sender.doubleValue;
    [self updateRightFrequencyLabel];
}

#pragma mark - Private Methods

- (void)updateButton {
    // Update button.
    NSString *buttonText;
    if (self.soundEngine.running) {
        buttonText = @"Stop";
    } else {
        buttonText = @"Start";
    }
    self.startStopButton.title = buttonText;
}

- (void)updateLeftFrequencyLabel {
    // Update left channel properties.
    NSInteger leftFrequency = (NSInteger)self.soundEngine.leftChannel.frequency;
    NSString *formattedLeftFrequency = [NSString stringWithFormat:@"Left Channel: %@ Hz", @(leftFrequency)];
    self.leftChannelFrequencyLabel.stringValue = formattedLeftFrequency;
}

- (void)updateRightFrequencyLabel {
    // Update right channel properties.
    NSInteger rightFrequency = (NSInteger)self.soundEngine.rightChannel.frequency;
    NSString *formattedRightFrequency = [NSString stringWithFormat:@"Right Channel: %@ Hz", @(rightFrequency)];
    self.rightChannelFrequencyLabel.stringValue = formattedRightFrequency;
}

@end
