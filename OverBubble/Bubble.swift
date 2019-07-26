//
//  Bubble.swift
//  OverBubble
//
//  Created by Simone Girardi on 05/07/2019.
//  Copyright © 2019 Simone Girardi. All rights reserved.
//

import Foundation
import Cocoa

class Bubble {
    
    private var layer: CALayer
    private var posX: CGFloat
    private var posY: CGFloat
    private var radius: CGFloat
    private var identifier: Int
    
    private let shapeLayer = CAShapeLayer()
    
    private static var identifierFactory  = 0

    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    func getLocation() -> NSPoint {
        return NSPoint(x: posX, y: posY)
    }
    
    
    func update(posX: CGFloat, posY: CGFloat) {
        
        let oldPath = CGMutablePath()
        let oldCenterPoint = CGPoint(x: self.posX, y: self.posY)
        oldPath.addArc(center: oldCenterPoint, radius: radius, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        
        self.posX = posX
        self.posY = posY
        
        
        let path = CGMutablePath()
        let centerPoint = CGPoint(x: posX, y: posY)
        path.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        
        
        // animate the `path`
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = oldPath
        animation.toValue = path
        animation.duration = 0.1
    
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: animation.keyPath)
    }
    
    
    func drawBubble() {
        shapeLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        shapeLayer.lineWidth = 2
        let path = CGMutablePath()
        let centerPoint = CGPoint(x: posX, y: posY)
        path.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
    
    
    init(layer: CALayer, posX: CGFloat, posY:CGFloat, radius: CGFloat) {
        self.layer = layer
        self.posX = posX
        self.posY = posY
        self.radius = radius
        self.identifier = Bubble.getUniqueIdentifier()
    }
    
    
    
}
