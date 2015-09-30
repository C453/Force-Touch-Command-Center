//
//  ForceTouchButton.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa

class ForceTouchButton: NSButton {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        self.wantsLayer = true
        self.layer?.cornerRadius  = Options.Shape.rawValue
        self.alphaValue = 0.0001
    }
}
