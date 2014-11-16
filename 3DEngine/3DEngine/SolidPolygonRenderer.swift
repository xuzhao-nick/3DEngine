//
//  SolidPolygonRenderer.swift
//  3DEngine
//
//  Created by Xu Zhao on 16/11/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
/**
    The SolidPolygonRenderer class transforms and draws
    solid-colored polygons onto the screen.
*/
class SolidPolygonRenderer :PolygonRenderer {
    
    init(camera:Transform3D,
        viewWindow:ViewWindow)
    {
        super.init(camera: camera, viewWindow: viewWindow, clearViewEveryFrame: true)
    }
    
    override init(camera:Transform3D,
        viewWindow:ViewWindow,  clearViewEveryFrame:Bool)
    {
        super.init(camera: camera, viewWindow: viewWindow, clearViewEveryFrame: clearViewEveryFrame)
    }
    
    
    /**
        Draws the current polygon. At this point, the current
        polygon is transformed, clipped, projected,
        scan-converted, and visible.
    */
    override func drawCurrentPolygon(context:CGContextRef) {
        
        // set line width
        CGContextSetLineWidth(context, 1.0)
        // set the color
        if (sourcePolygon is SolidPolygon3D) {
            let solidPolygon:SolidPolygon3D =  self.sourcePolygon as SolidPolygon3D
            CGContextSetStrokeColorWithColor(context, solidPolygon.color.CGColor )

        }
        else {
           CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor )
        }
        
        // draw the scans
        var y = scanConverter.topBoundary
        while (y <= scanConverter.bottomBoundary) {
            let scan:Scan = scanConverter.getScan(y)
            if (scan.isValid()) {
                CGContextMoveToPoint(context, CGFloat(scan.left),CGFloat(y))
                CGContextAddLineToPoint(context, CGFloat(scan.right),CGFloat(y))
            }
            y++
        }
        CGContextStrokePath(context)
    }
}