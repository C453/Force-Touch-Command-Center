//
//  PopupWindowController.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa
import AudioToolbox

class PopupWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.backgroundColor = NSColor.clearColor()
        self.window?.level = Int(CGWindowLevelForKey(.MaximumWindowLevelKey))
    }
    
    @IBAction func forceTouchBtnClick(sender: NSButton) {
        if(sender.doubleValue == 0) { return }
        
        switch(Options.action) {
        case .Brightness:
            setBrightness(Float(sender.doubleValue * 0.2))
            break
        case .Volume:
            setVolume(Float(sender.doubleValue - 1))
            break
        default:
            break
        }
        Swift.print("DOME")
    }
    
    func setBrightness(level:Float) {
        var iterator:io_iterator_t = 0
        let result:kern_return_t = IOServiceGetMatchingServices(kIOMasterPortDefault,
            IOServiceMatching("IODisplayConnect"),
            &iterator);
        
        if(result != kIOReturnSuccess) { return }
        
        var service: io_object_t = 1
        
        for ;; {
            service = IOIteratorNext(iterator)
            
            if service == 0 {
                break
            }
            
            IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey, level)
            IOObjectRelease(service)
        }
    }
    
    func setVolume(var level:Float) {
        let volumeSize = UInt32(sizeofValue(level))
        
        var volumePropertyAddress = AudioObjectPropertyAddress(
            mSelector: AudioObjectPropertySelector(kAudioHardwareServiceDeviceProperty_VirtualMasterVolume),
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
