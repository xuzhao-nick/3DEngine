//
//  Vector3D.swift
//  3DEngine
//
//  Created by Xu Zhao on 19/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation

class Vector3D {
    
    var x:Float = 0.0
    var y:Float = 0.0
    var z:Float = 0.0
    
    /**
        Creates a new Vector3D with the same values as the
        specified Vector3D.
    */
    init(vector3D: Vector3D) {
        
        x = vector3D.x
        y = vector3D.y
        z = vector3D.z
    }
    
    /**
        Creates a new Vector3D with the specified (x, y, z) values.
    */
    init(x:Float, y:Float, z:Float) {
        
        self.x = x
        self.y = y
        self.z = z
    }
    
    /**
        Checks if this Vector3D is equal to the specified
        x, y, and z coordinates.
    */
    func equals(x:Float, y:Float, z:Float) -> Bool {
        
        return (self.x == x && self.y == y && self.z == z);
    }
    
    /**
        Checks if this Vector3D is equal to the specified Object.
        They are equal only if the specified Object is a Vector3D
        and the two Vector3D's x, y, and z coordinates are equal.
    */
    func equals(vector:Vector3D) -> Bool {
    
        return (vector.x == x && vector.y == y && vector.z == z);
    }

    /**
        Sets the vector to the same values as the specified
        Vector3D.
    */
    func setTo(v:Vector3D) {
        
        setTo(v.x, y: v.y, z: v.z)
    }
    
    /**
        Sets this vector to the specified (x, y, z) values.
    */
    func setTo(x:Float, y:Float, z:Float) {
        
        self.x = x;
        self.y = y;
        self.z = z;
    }

    /**
        Adds the specified (x, y, z) values to this vector.
    */
    func add(x:Float, y:Float, z:Float) {
        
        self.x += x;
        self.y += y;
        self.z += z;
    }
    
    
    /**
        Subtracts the specified (x, y, z) values to this vector.
    */
    func subtract(x:Float, y:Float, z:Float) {
        
        add(-x, y:-y, z:-z);
    }
    
    
    /**
        Adds the specified vector to this vector.
    */
    func add(v:Vector3D) {
        
        add(v.x, y:v.y, z:v.z);
    }
    
    
    /**
        Subtracts the specified vector from this vector.
    */
    func subtract(v:Vector3D) {
        
        add(-v.x, y:-v.y, z:-v.z);
    }
    
    
    /**
        Multiplies this vector by the specified value. The new
        length of this vector will be length()*s.
    */
    func multiply(s:Float) {
        
        x *= s;
        y *= s;
        z *= s;
    }
    
    
    /**
        Divides this vector by the specified value. The new
        length of this vector will be length()/s.
    */
    func divide(s:Float) {
        
        x /= s;
        y /= s;
        z /= s;
    }
    
    
    /**
        Returns the length of this vector as a float.
    */
    func length()->Float {
        
        return Float(sqrt(x * x + y * y + z * z));
    }
    
    
    /**
        Converts this Vector3D to a unit vector, or, in other
        words, a vector of length 1. Same as calling
        v.divide(v.length()).
    */
    func normalize() {
        
        divide(length());
    }
    
    
    /**
        Converts this Vector3D to a String representation.
    */
    func toString()->String {
        
        return "(\(x),\(y),\(z))";
}


}