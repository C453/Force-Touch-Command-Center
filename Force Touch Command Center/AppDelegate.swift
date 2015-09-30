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
    let settings = NSUserDefaults.standardUserDefaults()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if settings.boolForKey("notFirstLaunch") == false {
            //First Launch
            settings.setBool(true, forKey: "notFirstLaunch")
            settings.setFloat(Options.lowerLimit, forKey: "lowerLimit")
            settings.setFloat(Options.upperLimit, forKey: "upperLimit")
            settings.setBool(Options.showLevel, forKey: "showLevel")
            settings.setBool(Options.showSlider, forKey: "showSlider")
            settings.setFloat(Float(Options.Shape.rawValue), forKey: "shapeType")
            settings.setInteger(Options.action.rawValue, forKey: "action")
        }

        Options.lowerLimit = settings.floatForKey("lowerLimit")
        Options.upperLimit = settings.floatForKey("upperLimit")
        Options.showLevel = settings.boolForKey("showLevel")
        Options.showSlider = settings.boolForKey("showSlider")
        Options.Shape = ShapeType(rawValue: CGFloat(settings.floatForKey("shapeType")))!
        Options.action = ActionType(rawValue: settings.integerForKey("action"))!

        StatusItem.button?.title = "Options"
        StatusItem.button?.image = NSImage(named: "statusIcon")
        Options.optionsWindowController = OptionsWindowController(
            windowNibName: "OptionsWindowController")
        Options.popupWindowController = PopupWindowController(
            windowNibName: "PopupWindowController")

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Options", action: Selector(
            "openOptions"), keyEquivalent: ""))
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