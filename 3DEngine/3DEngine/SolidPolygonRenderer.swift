//
//  SolidPolygonRenderer.swift
//  3DEngine
//
//  Created by Xu Zhao on 16/11/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation
import UIKit
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
        
        // set the color
        if (sourcePolygon instanceof SolidPolygon3D) {
            g.setColor(((SolidPolygon3D)sourcePolygon).getColor());
        }
        else {
            g.setColor(Color.GREEN);
        }
        
        // draw the scans
        int y = scanConverter.getTopBoundary();
        while (y<=scanConverter.getBottomBoundary()) {
            ScanConverter.Scan scan = scanConverter.getScan(y);
            if (scan.isValid()) {
                g.drawLine(scan.left, y, scan.right, y);
            }
            y++;
        }
    }
}