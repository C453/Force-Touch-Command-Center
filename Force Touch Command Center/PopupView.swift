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
        self.layer?.cornerRadius  = Options.Shape.rawValue
        self.layer?.backgroundColor = NSColor(white: 0, alpha: 0.5).CGColor

        TrackingArea = NSTrackingArea(rect: self.bounds, options:
            [NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveAlways],
            owner: self, userInfo: nil)

        self.addTrackingArea(TrackingArea)
    }

    override func mouseExited(theEvent: NSEvent) {
        animator().alphaValue = 0
        Options.delay(0.22) {
            Options.popupWindowController?.close()
            self.alphaValue = 0.8
        }
        super.mouseExited(theEvent)
    }
}
