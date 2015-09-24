//
//  AppDelegate.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let StatusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        StatusItem.button?.title = "Options"
        Options.optionsWindowController = OptionsWindowController(windowNibName: "OptionsWindowController")
        Options.popupWindowController = PopupWindowController(windowNibName: "PopupWindowController")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Options", action: Selector("openOptions"), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: ""))
        
        StatusItem.menu = menu
        
        Options.getVolumeDevice()
    MASShortcutBinder.sharedBinder().bindShortcutWithDefaultsKey("GlobalShortcut") { () -> Void in
            self.openPopup()
            self.centerCursor()
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func openOptions() {
        Options.optionsWindowController?.showWindow(self)
    }
    
    func openPopup() {
        Options.popupWindowController?.showWindow(self)
    }
    
    func centerCursor() {
        CGDisplayMoveCursorToPoint(0, Options.center)
    }
}

