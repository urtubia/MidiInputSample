//
//  MidiInputSampleViewController.m
//  MidiInputSample
//
//  Created by hector urtubia on 11/30/13.
//  Copyright (c) 2013 Big Robot Studios, LLC. All rights reserved.
//

#import "MidiInputSampleViewController.h"

static void PGMIDINotifyProc(const MIDINotification *message, void *refCon);
static void PGMIDIReadProc(const MIDIPacketList *pktlist, void *readProcRefCon, void *srcConnRefCon);
static void PGMIDIVirtualDestinationReadProc(const MIDIPacketList *pktlist, void *readProcRefCon, void *srcConnRefCon);

@interface MidiInputSampleViewController ()

@end

@implementation MidiInputSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        OSStatus s = MIDIClientCreate((CFStringRef)@"PGMidi MIDI Client", PGMIDINotifyProc, (__bridge void*)self, &client);
        s = MIDIOutputPortCreate(client, (CFStringRef)@"PGMidi Output Port", &outputPort);
        s = MIDIInputPortCreate(client, (CFStringRef)@"PGMidi Input Port", PGMIDIReadProc, NULL, &inputPort);
        NSString *name = @"asdf";
        s = MIDIDestinationCreate(client, (__bridge CFStringRef)name, PGMIDIVirtualDestinationReadProc, (__bridge void*)self, &virtualDestinationEndpoint);

        
        const ItemCount numberOfSources      = MIDIGetNumberOfSources();
        
        for (ItemCount index = 0; index < numberOfSources; ++index)
        {
            MIDIEndpointRef endpoint = MIDIGetSource(index);
            s = MIDIPortConnectSource(inputPort, endpoint, NULL);
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSString *StringFromPacket(const MIDIPacket *packet)
{
    // Note - this is not an example of MIDI parsing. I'm just dumping
    // some bytes for diagnostics.
    // See comments in PGMidiSourceDelegate for an example of how to
    // interpret the MIDIPacket structure.
    return [NSString stringWithFormat:@"  %u bytes: [%02x,%02x,%02x]",
            packet->length,
            (packet->length > 0) ? packet->data[0] : 0,
            (packet->length > 1) ? packet->data[1] : 0,
            (packet->length > 2) ? packet->data[2] : 0
            ];
}

static
void PGMIDIReadProc(const MIDIPacketList *pktlist, void *readProcRefCon, void *srcConnRefCon)
{
    const MIDIPacket *packet = &pktlist->packet[0];
    for (int i = 0; i < pktlist->numPackets; ++i)
    {
        NSLog(@"%@", StringFromPacket(packet));
        packet = MIDIPacketNext(packet);
    }

}

static
void PGMIDIVirtualDestinationReadProc(const MIDIPacketList *pktlist, void *readProcRefCon, void *srcConnRefCon)
{

}

void PGMIDINotifyProc(const MIDINotification *message, void *refCon)
{

}

@end
