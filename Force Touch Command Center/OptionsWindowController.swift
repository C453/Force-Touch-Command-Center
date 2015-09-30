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
    @IBOutlet weak var showSliderCheck: NSButton!
    @IBOutlet weak var showLevelCheck: NSButton!

    override func windowDidLoad() {
        super.windowDidLoad()
        if Options.action == .Volume { ActionComboBox.selectItemAtIndex(0) }
        else { ActionComboBox.selectItemAtIndex(1) }
        
        if(Options.Shape == .Square) { overlayShapeSegmentedControl.selectedSegment = 0 }
        else { overlayShapeSegmentedControl.selectedSegment = 1 }
        showSliderCheck.state = Options.showSlider.boolValue.toInt()!
        showLevelCheck.state = Options.showLevel.boolValue.toInt()!
        RangeSlider.action = "updateRange:"
        RangeSlider.minValue = 0.1
        RangeSlider.maxValue = 1
        RangeSlider.lowerValue = Double(Options.lowerLimit)
        RangeSlider.upperValue = Double(Options.upperLimit)
        RangeSlider.trackHighlightTintColor = NSColor(red: 0.4, green: 0.698, blue: 1.0, alpha: 1.0)
        RangeSlider.cellWidth = 20
        RangeSlider.cellHeight = 30

        self.shortcutView.associatedUserDefaultsKey = Options.kPreferenceGlobalShortcut
    }

    @IBAction func ActionBoxValueChanged(sender: NSComboBox) {
            NSUserDefaults.standardUserDefaults().setInteger((sender.selectedCell()?.integerValue)!, forKey: "action")
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

    @IBAction func showSliderValueChanged(sender: NSButton) {
        Options.showSlider = sender.state.toBool()!
        NSUserDefaults.standardUserDefaults().setBool(Options.showSlider, forKey: "showSlider")
    }

    @IBAction func showLevelValueChanged(sender: NSButton) {
        Options.showLevel = sender.state.toBool()!
        NSUserDefaults.standardUserDefaults().setBool(Options.showLevel, forKey: "showLevel")
    }
}