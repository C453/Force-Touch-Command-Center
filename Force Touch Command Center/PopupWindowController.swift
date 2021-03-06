//
//  PopupWindowController.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa
import AudioToolbox
import ForceFeedback

class PopupWindowController: NSWindowController {

    @IBOutlet weak var ValueLabel: NSTextField!
    @IBOutlet weak var ValueSlider: NSSlider!

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.backgroundColor = NSColor.clearColor()
        //keep GUI on top
        self.window?.level = Int(CGWindowLevelForKey(.MaximumWindowLevelKey))
        ValueLabel.alphaValue = 0.5
        ValueSlider.alphaValue = 0.5
        if !Options.showLevel { ValueLabel.hidden = true }
        if !Options.showSlider { ValueSlider.hidden = true }
    }

    @IBAction func forceTouchBtnClick(sender: NSButton) {
        //prevent value from changing when finger leaves touchpad
        if sender.doubleValue == 0 { return }

        /*
            NSButton returns a value of 0-5, here we
            must convert that to a value from 0 to 1.
        
            In the future, if we want a range greater
            than 1-5, we can call:
                NSHapticFeedbackManager.defaultPerformer().
                performFeedbackPattern(.Generic, 
                performanceTime: .Now)
            to simulate a increment.
        */

        ValueLabel.stringValue = String(sender.integerValue)
        ValueSlider.integerValue = sender.integerValue

        let increment: Float = ((Options.upperLimit - Options.lowerLimit) / 5)
        //0..1
        let value = Float(sender.doubleValue) * increment  + (Options.lowerLimit)

        switch Options.action {
        case .Brightness:
            setBrightness(value)
            return
        case .Volume:
            setVolume(value)
            return
        }
    }

    func setBrightness(level: Float) {
        var iterator: io_iterator_t = 0
        let result: kern_return_t = IOServiceGetMatchingServices(kIOMasterPortDefault,
            IOServiceMatching("IODisplayConnect"),
            &iterator);

        if result != kIOReturnSuccess { return }
        var service: io_object_t = 1
        while true {
            service = IOIteratorNext(iterator)
            if service == 0 { break }
            IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey, level)
            IOObjectRelease(service)
        }
    }

    func setVolume(var level: Float) {
        let volumeSize = UInt32(sizeofValue(level))

        var volumePropertyAddress = AudioObjectPropertyAddress(
            mSelector: AudioObjectPropertySelector(
                kAudioHardwareServiceDeviceProperty_VirtualMasterVolume),
            mScope: AudioObjectPropertyScope(kAudioDevicePropertyScopeOutput),
            mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMaster))

        AudioHardwareServiceSetPropertyData(
            Options.defaultOutputDeviceID,
            &volumePropertyAddress,
            0,
            nil,
            volumeSize,
            &level)
    }

}
