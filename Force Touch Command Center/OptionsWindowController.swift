//
//  OptionsWindowController.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa
import MASShortcut
import JMSRangeSlider

class OptionsWindowController: NSWindowController {

    
    @IBOutlet weak var overlayShapeSegmentedControl: NSSegmentedControl!
    @IBOutlet weak var ActionComboBox: NSComboBox!
    @IBOutlet weak var shortcutView: MASShortcutView!
    @IBOutlet weak var RangeSlider: JMSRangeSlider!

    override func windowDidLoad() {
        super.windowDidLoad()
        if Options.action == .Volume { ActionComboBox.selectItemAtIndex(0) }
        else { ActionComboBox.selectItemAtIndex(1) }
        
        if(Options.Shape == .Square) { overlayShapeSegmentedControl.selectedSegment = 0 }
        else { overlayShapeSegmentedControl.selectedSegment = 1 }

        RangeSlider.action = "updateRange:"
        RangeSlider.minValue = 0.1
        RangeSlider.maxValue = 1
        RangeSlider.lowerValue = Double(Options.lowerLimit)
        RangeSlider.upperValue = Double(Options.upperLimit)

        self.shortcutView.associatedUserDefaultsKey = Options.kPreferenceGlobalShortcut
    }

    @IBAction func ActionBoxValueChanged(sender: NSComboBox) {
        if sender.selectedCell()?.title == "Volume" {
            Options.action = .Volume
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "Action")
        } else {
            Options.action = .Brightness
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "Action")
        }
    }

    func updateRange(sender: JMSRangeSlider) {
        Options.lowerLimit = Float(sender.lowerValue)
        Options.upperLimit = Float(sender.upperValue)

        NSUserDefaults.standardUserDefaults().setFloat(Options.lowerLimit, forKey: "lowerLimit")
        NSUserDefaults.standardUserDefaults().setFloat(Options.upperLimit, forKey: "upperLimit")
    }
    
    @IBAction func overlayShapeBtnValueChanged(sender: NSSegmentedControl) {
        switch(sender.selectedSegment) {
        case 0:
            Options.Shape = .Square
            break
        case 1:
            Options.Shape = .Circle
            break
        default:
            break
        }
        
        NSUserDefaults.standardUserDefaults().setFloat(Float(Options.Shape.rawValue), forKey: "shapeType")
    }
}