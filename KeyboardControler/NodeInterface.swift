//
//  NodeInterface.swift
//  MSIKeyboard
//
//  Created by Jakob on 11/08/2015.
//  Copyright (c) 2015 Jakob. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

 public struct NodeInterface
{
    let Defs = NSUserDefaults.standardUserDefaults()
    
    
    static func GetColor(value : Int) -> NSColor
    {
        
        switch value{
        case 0: return NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.7)
        case 1: return NSColor(calibratedRed: NSColor.redColor().redComponent, green: NSColor.redColor().greenComponent, blue: NSColor.redColor().blueComponent, alpha: 0.7)
        case 2: return NSColor(calibratedRed: 1, green:150/255, blue : 50/255, alpha: 0.7)
        case 3: return NSColor(calibratedRed: NSColor.yellowColor().redComponent, green: NSColor.yellowColor().greenComponent, blue: NSColor.yellowColor().blueComponent, alpha: 0.7)
        case 4: return NSColor(calibratedRed: NSColor.greenColor().redComponent, green: NSColor.greenColor().greenComponent, blue: NSColor.greenColor().blueComponent, alpha: 0.7)
        case 5: return NSColor(calibratedRed: 0, green:165/255, blue: 1, alpha: 0.7)
        case 6: return NSColor(calibratedRed: NSColor.blueColor().redComponent, green: NSColor.blueColor().greenComponent, blue: NSColor.blueColor().blueComponent, alpha: 0.7)
        case 7: return NSColor(calibratedRed: NSColor.purpleColor().redComponent, green: NSColor.purpleColor().greenComponent, blue: NSColor.purpleColor().blueComponent, alpha: 0.7)
        case 8: return NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 0.7)
        default: return NSColor.blackColor()        }
        
    }
    
    static func  InvertColor (basecolor : NSColor)-> NSColor{
        return NSColor(calibratedRed: 1-basecolor.redComponent, green: 1-basecolor.greenComponent, blue: 1-basecolor.blueComponent, alpha: 1)
    }
    
     static let Colors : [String] = [
        "off",
        "red",
        "orange",
        "yellow",
        "green",
        "sky",
        "blue",
        "purple",
        "white"
    ]
    
    
    static let Effects :[String] = [
    "off",
    "blink",
        "wave"
    
    ]
    
    static func SetColor(zone : Int, color : String)->Bool{
        
         //let settings = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Settings", ofType: "plist")!)
        println(NSBundle.mainBundle().resourcePath!+"/node")
        var path = NSBundle.mainBundle().resourcePath!+"/apply.js"
        switch zone {
        case 0: ("var findKeyboard = require('./findKeyboard');\nvar keyboard = findKeyboard();\nkeyboard.color('left', {\ncolor: '"+color+"',\nintensity: 'high',\n});").writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        case 1:("var findKeyboard = require('./findKeyboard');\nvar keyboard = findKeyboard();\nkeyboard.color('middle', {\ncolor: '"+color+"',\nintensity: 'high'\n});").writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        case 2:("var findKeyboard = require('./findKeyboard');\nvar keyboard = findKeyboard();\nkeyboard.color('right', {\ncolor: '"+color+"',\nintensity: 'high'\n});").writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
            default:("var findKeyboard = require('./findKeyboard');\nvar keyboard = findKeyboard();\nkeyboard.color('left', {\ncolor: off',\nintensity: 'high'\n});").writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        }
        
        //println(NSBundle.mainBundle().resourcePath!+"/node")
        let task = NSTask()
        task.launchPath = NSBundle.mainBundle().resourcePath!+"/node"
        task.arguments = [path]
        task.launch()
        task.waitUntilExit()
        NSFileManager.defaultManager().removeItemAtPath(path, error: nil)
        return true //imlement error
    }

    
}