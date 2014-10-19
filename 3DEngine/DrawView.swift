//
//  DrawView.swift
//  3DEngine
//
//  Created by Xu Zhao on 19/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import UIKit
import CoreGraphics
class DrawView:UIView {
    
    // create solid-colored polygons
    let treeLeaves:SolidPolygon3D = SolidPolygon3D(
    v0: Vector3D(x: -50, y: -35, z: 0),
    v1: Vector3D(x: 50, y: -35, z: 0),
    v2: Vector3D(x: 0, y: 150, z: 0))
    
    let treeTrunk:SolidPolygon3D = SolidPolygon3D(
    v0: Vector3D(x: -5, y: -50, z: 0),
    v1: Vector3D(x: 5, y: -50, z: 0),
    v2: Vector3D(x: 5, y: -35, z: 0),
    v3: Vector3D(x: -5, y: -35, z: 0))
    
    var treeTransform:Transform3D  = Transform3D(x: 0,y: 0,z: -500)
    var transformedPolygon:Polygon3D  = Polygon3D()
    var viewWindow: ViewWindow = ViewWindow()

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.blackColor()
        treeLeaves.color = UIColor.greenColor()
        treeTrunk.color = UIColor.yellowColor()
        // make the view window the entire screen
        viewWindow = ViewWindow(left: 0, top: 0, width: Int(self.frame.size.width), height: Int(self.frame.size.height), angle: Float(75.0 * M_PI / 180.0))

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {

    }
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        var context = UIGraphicsGetCurrentContext()
        // draw the tree polygons
        trandformAndDraw(context, poly: treeTrunk);
        trandformAndDraw(context, poly: treeLeaves);
        
    }
    
    /**
    Projects and draws a polygon onto the view window.
    */
    func trandformAndDraw(context: CGContextRef,
        poly:SolidPolygon3D)
    {
        
        CGContextSetStrokeColorWithColor(context, poly.color.CGColor)
        CGContextSetLineWidth(context, 1.0);
        transformedPolygon.setTo(poly)
        
        // translate and rotate the polygon
        transformedPolygon.add(treeTransform)
        
        // project the polygon to the screen
        transformedPolygon.project(viewWindow)
        
        // draw the transformed polygon
        var v = transformedPolygon.getVertex(0)
        CGContextMoveToPoint(context, CGFloat(v.x), CGFloat(v.y))
        
        for i in 1...(transformedPolygon.numVertices - 1) {
            v = transformedPolygon.getVertex(i)
            CGContextAddLineToPoint(context, CGFloat(v.x), CGFloat(v.y));
        }
        CGContextSetFillColorWithColor(context, poly.color.CGColor);
        CGContextFillPath(context);

    }
    
    
}