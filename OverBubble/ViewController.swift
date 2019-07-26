//
//  ViewController.swift
//  OverBubble
//
//  Created by Simone Girardi on 05/07/2019.
//  Copyright © 2019 Simone Girardi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let rootLayer = CALayer()
    var mouseLocation: NSPoint {
        return NSEvent.mouseLocation
    }
    
    override func viewWillAppear() {
        
        let bigBubble = Bubble(layer: rootLayer, posX: 128, posY: 128, radius: 64)
        let smallBubble = Bubble(layer: rootLayer, posX: 256, posY: 128, radius: 32)
        
        bigBubble.drawBubble()
        smallBubble.drawBubble()
        
        self.view.window?.acceptsMouseMovedEvents = true
        
        
        NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) {
            
            // check if mouse is inner window and update smallBubble position
            if NSWindow.windowNumber(at: self.mouseLocation, belowWindowWithWindowNumber: 0) == self.view.window?.windowNumber {
                smallBubble.update(posX: self.mouseLocation.x-128-32, posY: self.mouseLocation.y-128-64)
            }
            
            
            let sbx = Float(abs(smallBubble.getLocation().x - bigBubble.getLocation().x))
            let sby = Float(abs(smallBubble.getLocation().y - bigBubble.getLocation().y))
            let ss = sqrt(powf(sbx,2) + powf(sby,2))
            
            if (ss <= 96) {
                print("intersection: \(Int(sbx)), \(Int(sby))")
                self.rootLayer.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            }
            else {
                self.rootLayer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            
            return $0
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootLayer.frame = self.view.frame
        rootLayer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.layer = rootLayer
        self.view.wantsLayer = true
    }
}

