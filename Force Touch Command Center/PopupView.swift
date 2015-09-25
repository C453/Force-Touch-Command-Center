//
//  PopupView.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa

class PopupView: NSView {
    var TrackingArea:NSTrackingArea!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        self.wantsLayer = true
        self.layer?.cornerRadius  = Options.CornerRad
        self.layer?.backgroundColor = NSColor(white: 0, alpha: 0.5).CGColor
        
        TrackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveInKeyWindow], owner: self, userInfo: nil)
        
        
        self.addTrackingArea(TrackingArea)
    }
    
    override func mouseExited(theEvent: NSEvent) {
        Options.popupWindowController?.close()
        super.mouseExited(theEvent)
    }
}
