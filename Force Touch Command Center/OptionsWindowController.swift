//
//  OptionsWindowController.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa

class OptionsWindowController: NSWindowController {
    
    @IBOutlet weak var ActionComboBox: NSComboBox!
    @IBOutlet weak var shortcutView: MASShortcutView!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        if(Options.action == .Volume) {
            ActionComboBox.selectItemAtIndex(0)
        } else {
            ActionComboBox.selectItemAtIndex(1)
        }
        
        self.shortcutView.associatedUserDefaultsKey = Options.kPreferenceGlobalShortcut
    }
    
    @IBAction func ActionBoxValueChanged(sender: NSComboBox) {
        if(sender.selectedCell()?.title == "Volume") {
            Options.action = .Volume
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "Action")
        } else {
            Options.action = .Brightness
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "Action")
        }
    }
}