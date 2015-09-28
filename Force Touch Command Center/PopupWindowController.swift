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
        ValueLabel.stringValue = ""
        ValueLabel.alphaValue = 0.5
        ValueSlider.alphaValue = 0.5
    }

    @IBAction func forceTouchBtnClick(sender: NSButton) {
        if sender.doubleValue == 0 { return }

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
