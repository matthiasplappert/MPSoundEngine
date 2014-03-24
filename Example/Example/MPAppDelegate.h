//
//  MPAppDelegate.h
//  Example
//
//  Created by Matthias Plappert on 24/03/14.
//  Copyright (c) 2014 Matthias Plappert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MPSoundEngine/MPStereoSoundEngine.h>

@interface MPAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSButton *startStopButton;
@property (weak) IBOutlet NSTextField *leftChannelFrequencyLabel;
@property (weak) IBOutlet NSSlider *leftChannelFrequencySlider;
@property (weak) IBOutlet NSTextField *rightChannelFrequencyLabel;
@property (weak) IBOutlet NSSlider *rightChannelFrequencySlider;

- (IBAction)startStop:(id)sender;
- (IBAction)leftChannelFrequencySliderDidChange:(NSSlider *)sender;
- (IBAction)rightChannelFrequencySliderDidChange:(NSSlider *)sender;

@end
