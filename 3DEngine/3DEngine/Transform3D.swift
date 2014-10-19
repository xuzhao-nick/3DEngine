//
//  Transform3D.swift
//  3DEngine
//
//  Created by Xu Zhao on 19/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation

/**
    The Transform3D class represents a rotation and translation.
*/

class Transform3D {
    
    var location:Vector3D = Vector3D(x: 0, y: 0, z: 0)
    private var cosAngleX_:Float = 0
    private var sinAngleX_:Float = 0
    private var cosAngleY_:Float = 0
    private var sinAngleY_:Float = 0
    private var cosAngleZ_:Float = 0
    private var sinAngleZ_:Float = 0
    
    /**
        Creates a new Transform3D with the specified translation
        and no rotation.
    */
    init (x:Float, y:Float, z:Float) {
        
        self.location = Vector3D(x: x, y: y, z: z)
        self.setAngle(0,angleY: 0,angleZ: 0);
    }
    
    /**
    Creates a new Transform3D
    */
    init(v:Transform3D) {
        
        location.x = v.location.x
        location.y = v.location.y
        location.z = v.location.z
        setTo(v);
    }
    
    
    func clone() ->Transform3D {
        
        return Transform3D(v: self);
        
    }
    
    
    func setAngle(angleX:Float, angleY:Float, angleZ:Float)
    {
        self.angleX = angleX
        self.angleY = angleY
        self.angleZ = angleZ
    }

    /**
        Sets this Transform3D to the specified Transform3D.
    */
    func setTo(v:Transform3D) {
        
        location.setTo(v.location);
        self.cosAngleX_ = v.cosAngleX;
        self.sinAngleX_ = v.sinAngleX;
        self.cosAngleY_ = v.cosAngleY;
        self.sinAngleY_ = v.sinAngleY;
        self.cosAngleZ_ = v.cosAngleZ;
        self.sinAngleZ_ = v.sinAngleZ;
    }

    
    func rotateAngleX(angle:Float) {
        
        if angle != 0 {
            self.angleX =  self.angleX + angle;
        }
        
    }
    
    func rotateAngleY(angle:Float) {
        
        if angle != 0 {
            self.angleY = self.angleY + angle;
    }
    }
    
    func rotateAngleZ(angle:Float) {
        
        if angle != 0 {
            self.angleZ =  self.angleZ + angle;
        }
    }
    
    func rotateAngle(angleX:Float, angleY:Float, angleZ:Float) {
        
        rotateAngleX(angleX);
        rotateAngleY(angleY);
        rotateAngleZ(angleZ);
    }

    var angleX:Float {
        get {
            return atan2(sinAngleX_, cosAngleX_);
        }
        set {
            cosAngleX_ = cos(newValue);
            sinAngleX_ = sin(newValue);
        }
    }
    
    var angleY:Float {
        get {
            return atan2(sinAngleY_, cosAngleY_);
        }
        set {
            cosAngleY_ = cos(newValue);
            sinAngleY_ = sin(newValue);
        }
    }
    
    var angleZ:Float {
        get {
            return atan2(sinAngleZ_, cosAngleZ_);
        }
        set {
            cosAngleZ_ = cos(newValue);
            sinAngleZ_ = sin(newValue);
        }
    }
    

    var cosAngleX:Float {
        get {
            return cosAngleX_;
        }
    }
    
    var sinAngleX:Float {
        get {
            return sinAngleX_;
        }
    }
    
    var cosAngleY:Float {
        get {
            return cosAngleY_;
        }
    }
    
    var sinAngleY:Float {
        get {
            return sinAngleY_;
        }
    }
    var cosAngleZ:Float {
        get {
            return cosAngleZ_;
        }
    }
    
    var sinAngleZ:Float {
        get {
            return sinAngleZ_;
        }
    }
    
    
}