//
//  Options.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Foundation
import AudioToolbox

struct Options {

    enum ActionType {
        case Volume, Brightness
    }

    static let kPreferenceGlobalShortcut = "GlobalShortcut";

    static var CornerRad:CGFloat = 30
    static var optionsWindowController : NSWindowController?
    static var popupWindowController : NSWindowController?
    static var defaultOutputDeviceID = AudioDeviceID(0)
    static var action:ActionType = .Brightness
    
    static var lowerLimit:Float = 0.1
    static var upperLimit:Float = 1
    
    static let center:CGPoint = CGPoint(x:CGDisplayPixelsWide(0) / 2, y:CGDisplayPixelsHigh(0) / 2)
    
    static func getVolumeDevice() {
        var defaultOutputDeviceIDSize = UInt32(sizeofValue(Options.defaultOutputDeviceID))
    
        var getDefaultOutputDevicePropertyAddress = AudioObjectPropertyAddress(
            mSelector: AudioObjectPropertySelector(kAudioHardwarePropertyDefaultOutputDevice),
            mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
            mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMaster))

        AudioObjectGetPropertyData(
            AudioObjectID(kAudioObjectSystemObject),
            &getDefaultOutputDevicePropertyAddress,
            0,
            nil,
            &defaultOutputDeviceIDSize,
            &Options.defaultOutputDeviceID)
    }

    static func delay(delay: Double, block:()->())
    {
        let nSecDispatchTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC)));
        let queue = dispatch_get_main_queue()
        dispatch_after(nSecDispatchTime, queue, block)
    }
}