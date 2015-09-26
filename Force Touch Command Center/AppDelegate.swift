//
//  AppDelegate.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/24/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Cocoa
import MASShortcut
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let StatusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

    func applicationDidFinishLaunching(aNotification: NSNotification) {

        Options.lowerLimit = NSUserDefaults.standardUserDefaults().floatForKey("lowerLimit")
        Options.upperLimit = NSUserDefaults.standardUserDefaults().floatForKey("upperLimit")
        
        assert(Options.lowerLimit < Options.upperLimit)

        switch NSUserDefaults.standardUserDefaults().integerForKey("Action") {
        case 0:
            Options.action = .Volume
            break
        case 1:
            Options.action = .Brightness
            break
        default:
            Options.action = .Brightness
            break
        }

        StatusItem.button?.title = "Options"
        StatusItem.button?.image = NSImage(named: "statusIcon")
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