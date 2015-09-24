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
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    self.shortcutView.associatedUserDefaultsKey = Options.kPreferenceGlobalShortcut
    }
    
    @IBAction func ActionBoxValueChanged(sender: NSComboBox) {
        if(sender.selectedCell()?.title == "Volume") {
            Options.action = .Volume
        } else {
            Options.action = .Brightness
        }
    }
}
