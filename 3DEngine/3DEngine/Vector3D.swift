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
    
    /**
        Rotate this vector around the x-axis the specified amount,
        using precomputed cosine and sine values of the angle to
        rotate.
    */
    func rotateX(cosAngle:Float, sinAngle:Float) {
        
        let newY:Float = y * cosAngle - z * sinAngle;
        let newZ:Float = y * sinAngle + z * cosAngle;
        y = newY;
        z = newZ;
    }
    
    
    /**
        Rotate this vector around the y-axis the specified amount,
        using precomputed cosine and sine values of the angle to
        rotate.
    */
    func rotateY(cosAngle:Float, sinAngle:Float) {
        
        let newX:Float = z * sinAngle + x * cosAngle;
        let newZ:Float = z * cosAngle - x * sinAngle;
        x = newX;
        z = newZ;
    }
    
    
    /**
        Rotate this vector around the y-axis the specified amount,
        using precomputed cosine and sine values of the angle to
        rotate.
    */
    func rotateZ(cosAngle:Float, sinAngle:Float) {
        
        let newX:Float = x * cosAngle - y * sinAngle;
        let newY:Float = x * sinAngle + y * cosAngle;
        x = newX;
        y = newY;
    }
    
    
    /**
        Adds the specified transform to this vector. This vector
        is first rotated, then translated.
    */
    func add(xform:Transform3D) {
    
        // rotate
        addRotation(xform);
    
        // translate
        add(xform.location);
    }
    
    
    /**
        Subtracts the specified transform to this vector. This
        vector is translated, then rotated.
    */
    func subtract(xform:Transform3D) {
    
        // translate
        subtract(xform.location);
    
        // rotate
        subtractRotation(xform);
    }
    
    
    /**
        Rotates this vector with the angle of the specified
        transform.
    */
    func addRotation(xform:Transform3D) {
    
        rotateX(xform.cosAngleX, sinAngle: xform.sinAngleX);
        rotateZ(xform.cosAngleZ, sinAngle: xform.sinAngleZ);
        rotateY(xform.cosAngleY, sinAngle: xform.sinAngleY);
    }
    
    
    /**
        Rotates this vector with the opposite angle of the
        specified transform.
    */
    func subtractRotation(xform:Transform3D) {
        
        // note that sin(-x) == -sin(x) and cos(-x) == cos(x)
        rotateY(xform.cosAngleY, sinAngle: -xform.sinAngleY);
        rotateZ(xform.cosAngleZ, sinAngle: -xform.sinAngleZ);
        rotateX(xform.cosAngleX, sinAngle: -xform.sinAngleX);
        
    }
    
    /**
        Returns the dot product of this vector and the specified
        vector.
    */
    func getDotProduct(v:Vector3D) ->Float {
        
        return x * v.x + y * v.y + z * v.z;
    }

    /**
        Sets this vector to the cross product of the two
        specified vectors. Either of the specified vectors can
        be this vector.
    */
    func setToCrossProduct(u:Vector3D, v:Vector3D) {
        
        // assign to local vars first in case u or v is 'this'
        let x:Float = u.y * v.z - u.z * v.y;
        let y:Float = u.z * v.x - u.x * v.z;
        let z:Float = u.x * v.y - u.y * v.x;
        self.x = x;
        self.y = y;
        self.z = z;
        
    }

}