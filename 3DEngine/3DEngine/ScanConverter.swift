//
//  ScanConverter.swift
//  3DEngine
//
//  Created by Xu Zhao on 20/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation

let SCALE_BITS:Int = 16
let SCALE:Int =  1 << SCALE_BITS
let SCALE_MASK:Int = SCALE - 1

class ScanConverter {
    

    var view:ViewWindow = ViewWindow(left: 0, top: 0, width: 0, height: 0, angle: 0)
    var scans:[Scan] = [Scan]()
    var top:Int = 0
    var bottom:Int = 0
    
    /**
        Creates a new ScanConverter for the specified ViewWindow.
        The ViewWindow's properties can change in between scan
        conversions.
    */
    init(view:ViewWindow) {
        self.view = view;
    }
    
    /**
        Gets the top boundary of the last scan-converted polygon.
    */
    var topBoundary:Int {
        get {
            return self.top
        }
    }
    
    /**
        Gets the bottom boundary of the last scan-converted
        polygon.
    */
    var bottomBoundary:Int {
        get {
            return self.bottom
        }
    }
    
    
    /**
        Gets the scan line for the specified y value.
    */
    func getScan(y:Int)->Scan {
        return scans[y]
    }

    /**
        Ensures this ScanConverter has the capacity to
        scan-convert a polygon to the ViewWindow.
    */
    func ensureCapacity() {
        
        let height:Int = view.topOffset + view.height
        
        if (scans.count != height) {
            scans = [Scan]()
            for (var i = 0; i < height; i++) {
                scans.append(Scan())
            }
            // set top and bottom so clearCurrentScan clears all
            top = 0;
            bottom = height - 1;
        }
    
    }
    
    /**
        Clears the current scan.
    */
    func clearCurrentScan() {
        
        for (var i = top; i <= bottom; i++) {
            scans[i].clear();
        }
        top = Int.max;
        bottom = Int.min;
    }
    
    /**
        Scan-converts a projected polygon. Returns true if the
        polygon is visible in the view window.
    */
    func convert(polygon:Polygon3D)->Bool {
    
        ensureCapacity()
        clearCurrentScan()
    
        var minX:Int = view.leftOffset;
        var maxX:Int = view.leftOffset + view.width - 1
        var minY:Int = view.topOffset
        var maxY:Int = view.topOffset + view.height - 1
    
        var numVertices:Int = polygon.numVertices
        for (var i = 0; i < numVertices; i++) {
            var v1:Vector3D = polygon.getVertex(i);
            var v2:Vector3D
            if (i == numVertices - 1) {
                v2 = polygon.getVertex(0);
            } else {
                v2 = polygon.getVertex(i+1);
            }
    
            // ensure v1.y < v2.y
            if (v1.y > v2.y) {
                var temp:Vector3D = v1
                v1 = v2
                v2 = temp
            }
            var dy:Float = v2.y - v1.y;
    
            // ignore horizontal lines
            if (dy == 0) {
                continue;
            }
    
            var startY:Int = max(MoreMath.ceil(v1.y), minY)
            var endY:Int = min(MoreMath.ceil(v2.y) - 1, maxY)
            top = min(top, startY)
            bottom = max(bottom, endY)
            var dx:Float = v2.x - v1.x
    
            // special case: vertical line
            if (dx == 0) {
                var x:Int = MoreMath.ceil(v1.x)
                // ensure x within view bounds
                x = min(maxX+1, max(x, minX))
                for (var y = startY; y <= endY; y++) {
                    scans[y].setBoundary(x)
                }
            } else {
                // scan-convert this edge (line equation)
                var gradient:Float = dx / dy
    
                // (slower version)
                /*
                for (int y=startY; y<=endY; y++) {
                    int x = MoreMath.ceil(v1.x + (y - v1.y) * gradient);
                    // ensure x within view bounds
                    x = Math.min(maxX+1, Math.max(x, minX));
                    scans[y].setBoundary(x);
                }
                */
    
                // (faster version)
    
                // trim start of line
                var startX:Float = Float(v1.x) + (Float(startY) - Float(v1.y)) * gradient
                if (startX < Float(minX)) {
                    var yInt:Int = Int(v1.y + (Float(minX) - v1.x) / gradient)
                    yInt = min(yInt, endY)
                    while (startY <= yInt) {
                        scans[startY].setBoundary(minX)
                        startY++
                    }
                } else if (startX > Float(maxX)) {
                    var yInt:Int = Int(v1.y + (Float(maxX) - v1.x) / gradient)
                    yInt = min(yInt, endY)
                    while (startY <= yInt) {
                        scans[startY].setBoundary(maxX+1)
                        startY++
                    }
                }
    
                if (startY > endY) {
                    continue;
                }
    
                // trim back of line
                var endX:Float = v1.x + (Float(endY) - v1.y) * gradient
                if (endX < Float(minX)) {
                    var yInt:Int = MoreMath.ceil(v1.y + (Float(minX) - v1.x) / gradient)
                    yInt = max(yInt, startY)
                    while (endY >= yInt) {
                        scans[endY].setBoundary(minX)
                        endY--
                    }
                } else if (endX > Float(maxX)) {
                    var yInt:Int = MoreMath.ceil(v1.y + (Float(maxX) - v1.x) / gradient)
                    yInt = max(yInt, startY)
                    while (endY >= yInt) {
                        scans[endY].setBoundary(maxX+1)
                        endY--
                    }
                }
    
                if (startY > endY) {
                    continue
                }
    
                // line equation using integers
                var xScaled:Int = Int(Float(SCALE) * v1.x + Float(SCALE) * (Float(startY) - v1.y) * dx / dy) + SCALE_MASK
                var dxScaled:Int = Int(Float(dx) * Float(SCALE) / dy)
    
                for (var y = startY; y <= endY; y++) {
                    scans[y].setBoundary(xScaled >> SCALE_BITS)
                    xScaled += dxScaled
                }
            }
        }
    
        // check if visible (any valid scans)
        for (var i = top; i <= bottom; i++) {
            if (scans[i].isValid()) {
                return true;
            }
        }
        return false;
    }
    
    
    
    
    
}