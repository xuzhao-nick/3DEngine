//
//  PolygonRenderer.swift
//  3DEngine
//
//  Created by Xu Zhao on 16/11/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation
import UIKit
class PolygonRenderer {
    var scanConverter:ScanConverter
    var camera:Transform3D
    var viewWindow:ViewWindow
    var clearViewEveryFrame:Bool
    var sourcePolygon:Polygon3D = Polygon3D()
    var destPolygon:Polygon3D
    
    /**
        Creates a new PolygonRenderer with the specified
        Transform3D (camera) and ViewWindow. If
        clearViewEveryFrame is true, the view is cleared when
        startFrame() is called.
    */
    init(camera:Transform3D,viewWindow:ViewWindow, clearViewEveryFrame:Bool) {
        self.camera = camera
        self.viewWindow = viewWindow
        self.clearViewEveryFrame = clearViewEveryFrame
        destPolygon = Polygon3D()
        scanConverter = ScanConverter(view: viewWindow)
    }
    
    
    /**
        Gets the camera used for this PolygonRenderer.
    */
    func getCamera()->Transform3D {
        return camera
    }
    
    
    /**
        Indicates the start of rendering of a frame. This method
        should be called every frame before any polygons are drawn.
    */
    func startFrame(context: CGContextRef) {
        if (clearViewEveryFrame) {
            CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
            CGContextAddRect(context, CGRectMake(CGFloat(viewWindow.leftOffset),
               CGFloat(viewWindow.topOffset), CGFloat(viewWindow.width), CGFloat(viewWindow.height)))
            CGContextFillPath(context)
        }
    }
    
    
    /**
        Indicates the end of rendering of a frame. This method
        should be called every frame after all polygons are drawn.
    */
    func endFrame(context: CGContextRef) {
        // do nothing, for now.
    }
    
    
    /**
        Transforms and draws a polygon.
    */
    func draw(context:CGContextRef,poly:Polygon3D)->Bool {
        if (poly.isFacing(camera.location)) {
            sourcePolygon = poly
            destPolygon.setTo(poly)
            destPolygon.subtract(camera)
            var visible:Bool = destPolygon.clip(-1)
            if (visible) {
                destPolygon.project(viewWindow)
                visible = scanConverter.convert(destPolygon)
                if (visible) {
                    drawCurrentPolygon(context)
                    return true
                }
            }
        }
        return false
    }
    
    
    /**
        Draws the current polygon. At this point, the current
        polygon is transformed, clipped, projected,
        scan-converted, and visible.
    */
    func drawCurrentPolygon(context:CGContextRef)
    {}
}