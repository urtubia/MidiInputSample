MidiInputSample
===============

Very minimal example of a iOS program that publishes itself as midi receiver, then outputs all received messages via NSLog. This code is used to illustrate that is not able to receive Midi Clock sync messages from Cubasis. It is however capable to receive midi messages from MoDrum.

Test case that shows Cubasis can send clock to Modrum
-----------------------------------------------------

* Close all apps on iOS
* Start Cubasis
* Ensure Cubasis sends midi clock messages by going to Tools and selecting the right option
* Hit play on Cubasis
* Start Modrum
* Ensure Modrum can listen to midi clock from Cubasis from the Midi menu
* Observe that the tempo is controlled by Cubasis

Test case that shows Modrum can send clock to MidiInputSample
-----------------------------------------------------

* Close all apps on iOS
* Start Modrum
* Ensure it sends midi clock from Midi Menu
* Start MidiInputSample from XCode
* Observe that on the console, several messages are output that look like this
    
    2013-11-30 22:22:26.424 MidiInputSample[643:3c03]   1 bytes: [f8,00,00]

Test case that shows Cubasis clock messages are not received by MidiInputSample
-----------------------------------------------------

* Close all apps on iOS
* Start Cubasis
* Ensure Cubasis sends midi clock messages by going to Tools and selecting the right option
* Hit play on Cubasis
* Start MidiInputSample from XCode
* Observe that on the console, no messages are output that look like this
    
    2013-11-30 22:22:26.424 MidiInputSample[643:3c03]   1 bytes: [f8,00,00]


