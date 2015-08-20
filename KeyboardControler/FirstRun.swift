//
//  FirstRun.swift
//  MSIKeyboard
//
//  Created by Jakob on 13/08/2015.
//  Copyright (c) 2015 Jakob. All rights reserved.
//

import Foundation


let Defs = NSUserDefaults.standardUserDefaults()

struct FirstRun
{
    static func Run(){

    if     ((NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Settings", ofType: "plist")!)?.valueForKey("firstrun") as? Bool) != false)
    {
        
        var dic = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Settings", ofType: "plist")!)
        dic!.setValue(false, forKey: "firstrun")
        dic?.writeToFile( NSBundle.mainBundle().pathForResource("Settings", ofType: "plist")!, atomically: true)
        Defs.setInteger(1, forKey: "color1")
        Defs.setInteger(1, forKey: "color2")
        Defs.setInteger(1, forKey: "color3")
        Defs.setInteger(0, forKey: "effect")
        Defs.synchronize()
        
        }
    else{return}
     
    
    }
}