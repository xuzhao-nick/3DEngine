//
//  ViewWindow.swift
//  3DEngine
//
//  Created by Xu Zhao on 19/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import UIKit
/**
    The ViewWindow class represents the geometry of a view window
    for 3D viewing.
*/
class ViewWindow {
    
    private var bounds : Rect = Rect(x: 0, y: 0, width: 0, height: 0)
    private var angle_ : Float = 0
    private var distanceToCamera : Float = 0
    
    /**
        Creates a new ViewWindow with the specified bounds on the
        screen and horizontal view angle.
    */
    init(left:Int, top:Int, width:Int, height:Int,
        angle:Float)
    {
        self.angle_ = angle;
        self.setBounds(left,top: top,width: width,height: height)
        
    }
    
    /**
        Gets the horizontal view angle of this view window.
    */
    var angle: Float {
        get {
            return self.angle
        }
        set {
            // Implement the setter here.
            self.angle_ = newValue
            setDistanceToCamera()
        }
    }
    
    /**
        Gets the width of this view window.
    */
    var width: Int {
        get {
            return self.bounds.width
        }
    }
    
    /**
        Gets the height of this view window.
    */
    var height: Int {
        get {
            return self.bounds.height
        }
    }
    
    /**
        Gets the y offset of this view window on the screen.
    */
    var topOffset: Int {
        get {
            return self.bounds.y
        }
    }
    
    /**
        Gets the x offset of this view window on the screen.
    */
    var leftOffset: Int {
        get {
            return self.bounds.x
        }
    }
    
    /**
        Gets the distance from the camera to this view window.
    */
    var distance: Float {
        get {
            return self.distanceToCamera
        }
    }
    
    
    /**
        Sets the bounds for this ViewWindow on the screen.
    */
    func setBounds(left:Int, top:Int, width:Int,
        height:Int)
    {
        bounds.x = left
        bounds.y = top
        bounds.width = width
        bounds.height = height
        self.setDistanceToCamera()
    }
    
    /**
        Sets the bounds for this ViewWindow on the screen.
    */
    func setDistanceToCamera() {
        
        self.distanceToCamera = (Float(bounds.width) / 2.0) /
            Float(tan(angle_ / 2.0));
        
    }
    
    
    /**
        Converts an x coordinate on this view window to the
        corresponding x coordinate on the screen.
    */
    func convertFromViewXToScreenX(x:Float)->Float {
        
        return x + Float(bounds.x) + Float(bounds.width) / 2.0;
        
    }

    
    /**
        Converts a y coordinate on this view window to the
        corresponding y coordinate on the screen.
    */
    func convertFromViewYToScreenY(y:Float)->Float {
        
        return -y + Float(bounds.y) + Float(bounds.height) / 2.0;
        
    }
    
    
    /**
        Converts an x coordinate on the screen to the
        corresponding x coordinate on this view window.
    */
    func convertFromScreenXToViewX(x:Float)->Float {
        
        return x - Float(bounds.x) - Float(bounds.width) / 2.0;
    }
    
    
    /**
        Converts a y coordinate on the screen to the
        corresponding y coordinate on this view window.
    */
    func convertFromScreenYToViewY(y:Float)->Float {
        
        return -y + Float(bounds.y) + Float(bounds.height) / 2.0;
    }
    
    
    /**
        Projects the specified vector to the screen.
    */
    func project(v:Vector3D) {
        
        // project to view window
        v.x = distanceToCamera * v.x / -v.z;
        v.y = distanceToCamera * v.y / -v.z;
    
        // convert to screen coordinates
        v.x = convertFromViewXToScreenX(v.x);
        v.y = convertFromViewYToScreenY(v.y);
    }
    
    
    

}