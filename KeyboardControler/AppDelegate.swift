//
//  AppDelegate.swift
//  KeyboardControler
//
//  Created by Jakob on 15/08/2015.
//  Copyright (c) 2015 Jakob. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var statusPopover: NSPopover!
    
    // Interfacefields
    
    @IBOutlet weak var ColorText_1: NSTextField!
    @IBOutlet weak var ColorText_2: NSTextField!
    @IBOutlet weak var ColorText_3: NSTextField!
    
    @IBOutlet weak var ColorPopup_1: NSPopUpButton!
    @IBOutlet weak var ColorPopup_2: NSPopUpButton!
    @IBOutlet weak var ColorPopup_3: NSPopUpButton!
    
    @IBOutlet weak var EffectsPopup: NSPopUpButton!
    
    //USerdefults
    
    let Defs = NSUserDefaults.standardUserDefaults()
   
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    var eventMonitor : EventMonitor?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        FirstRun.Run()
        var icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)

        statusItem.image = icon

        if let button = statusItem.button{
        button.action = Selector("togglePopover:")
            
        }
        
        
        eventMonitor = EventMonitor(mask: .LeftMouseDownMask | .RightMouseDownMask) { [unowned self] event in
            if self.statusPopover.shown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
        FillPopUps()
        restoreLast()
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            statusPopover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSMinYEdge)
        }
        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        statusPopover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject?) {
        if statusPopover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

    @IBAction func ShowSettingsWindow(sender: NSButton) {
    btnNewWindow(sender)

            }
    

    let myNewWindow = NSWindow(contentRect: NSMakeRect(0,0,640,480), styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
          /*  NSBorderlessWindowMask  = 0,
            NSTitledWindowMask  = 1 << 0,
            NSClosableWindowMask  = 1 << 1,
            NSMiniaturizableWindowMask  = 1 << 2,
            NSResizableWindowMask  = 1 << 3,
            NSTexturedBackgroundWindowMask  = 1 << 8*/

    @IBAction func btnNewWindow(sender: AnyObject) {
        
        myNewWindow.opaque = false
        myNewWindow.movableByWindowBackground = true
        myNewWindow.backgroundColor = NSColor(hue: 0, saturation: 1, brightness: 0, alpha: 0.7)
        myNewWindow.makeKeyAndOrderFront(nil)
    }
    // ----------------- Interface Functions----------------
    
    func restoreLast()
    {
        ColorChanged_1(ColorPopup_1)
        ColorChanged_2(ColorPopup_2)
        ColorChanged_3(ColorPopup_3)
    }
    
    func FillPopUps()
    {
        ColorPopup_1.addItemsWithTitles(NodeInterface.Colors)
        ColorPopup_2.addItemsWithTitles(NodeInterface.Colors)
        ColorPopup_3.addItemsWithTitles(NodeInterface.Colors)
        
        ColorPopup_1.selectItemAtIndex(Defs.integerForKey("color1"))
        ColorPopup_2.selectItemAtIndex(Defs.integerForKey("color2"))
        ColorPopup_3.selectItemAtIndex(Defs.integerForKey("color3"))
        
        EffectsPopup.addItemsWithTitles(NodeInterface.Effects)
        EffectsPopup.selectItemAtIndex(Defs.integerForKey("effect"))
        
    }
    
    @IBAction func ColorChanged_1(sender: NSPopUpButton) {
        ColorText_1.backgroundColor = NodeInterface.GetColor(ColorPopup_1.indexOfSelectedItem)
        ColorText_1.textColor  = NodeInterface.InvertColor(NodeInterface.GetColor(ColorPopup_1.indexOfSelectedItem))
  
        NodeInterface.SetColor(0, color: ColorPopup_1.selectedItem!.title as String)

        Defs.setInteger(ColorPopup_1.indexOfSelectedItem, forKey: "color1")
        Defs.synchronize()
    }
    @IBAction func ColorChanged_2(sender: AnyObject) {
        ColorText_2.backgroundColor = NodeInterface.GetColor(ColorPopup_2.indexOfSelectedItem)
        ColorText_2.textColor  = NodeInterface.InvertColor(NodeInterface.GetColor(ColorPopup_2.indexOfSelectedItem))
        
        NodeInterface.SetColor(1, color: ColorPopup_2.selectedItem!.title as String)
        
        Defs.setInteger(ColorPopup_2.indexOfSelectedItem, forKey: "color2")
        Defs.synchronize()
    }
    @IBAction func ColorChanged_3(sender: AnyObject) {
        ColorText_3.backgroundColor =  NodeInterface.GetColor(ColorPopup_3.indexOfSelectedItem)
        ColorText_3.textColor  = NodeInterface.InvertColor(NodeInterface.GetColor(ColorPopup_3.indexOfSelectedItem))
        
        NodeInterface.SetColor(2, color: ColorPopup_3.selectedItem!.title as String)
        
        Defs.setInteger(ColorPopup_3.indexOfSelectedItem, forKey: "color3")
        Defs.synchronize()
    }
}

