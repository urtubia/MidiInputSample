//
//  MidiInputSampleViewController.h
//  MidiInputSample
//
//  Created by hector urtubia on 11/30/13.
//  Copyright (c) 2013 Big Robot Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMIDI/CoreMIDI.h>

@interface MidiInputSampleViewController : UIViewController {
    MIDIClientRef client;
    MIDIPortRef outputPort;
    MIDIPortRef inputPort;
    MIDIEndpointRef    virtualSourceEndpoint;
    MIDIEndpointRef    virtualDestinationEndpoint;
}

@end
