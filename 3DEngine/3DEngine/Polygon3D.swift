//
//  Polygon3D.swift
//  3DEngine
//
//  Created by Xu Zhao on 19/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation

/**
    The Polygon3D class represents a polygon as a series of
    vertices.
*/
class Polygon3D {
    
    var v = [Vector3D]()
    var numVertices:Int = 0
    private var normal_ = Vector3D(x: 0, y: 0, z: 0)
    
    /**
        Creates a new Polygon3D with the specified vertices.
    */
    init(v0:Vector3D, v1:Vector3D, v2:Vector3D) {
        
        v = [Vector3D]()
        v.append(v0)
        v.append(v1)
        v.append(v2)
        numVertices = 3
    }
    
    init() {
        
    }
    
    /**
        Creates a new Polygon3D with the specified vertices. All
        the vertices are assumed to be in the same plane.
    */
    init(v0:Vector3D, v1:Vector3D, v2:Vector3D,
        v3:Vector3D)
    {
        v = [Vector3D]()
        v.append(v0)
        v.append(v1)
        v.append(v2)
        v.append(v3)
        numVertices = 4
    }
    
    /**
        Creates a new Polygon3D with the specified vertices. All
        the vertices are assumed to be in the same plane.
    */
    init(vertices:[Vector3D]) {
        
        self.v = vertices;
        numVertices = self.v.count
        
    }

    
    /**
        Sets this polygon to the same vertices as the specified
        polygon.
    */
    func setTo(polygon:Polygon3D) {
        
        ensureCapacity(polygon.numVertices);
        
        for i in 0...(numVertices - 1) {
            v[i].setTo(polygon.v[i]);
        }
    }
    
    /**
        Ensures this polygon has enough capacity to hold the
        specified number of vertices.
    */
    func ensureCapacity(length:Int) {
        
        
        if v.count < length {
            
            for i in 1...(length - numVertices) {
                v.append(Vector3D(x: 0, y: 0, z: 0))
            }
            
        }
        numVertices = length
    }
    
    /**
        Gets the vertex at the specified index.
    */
    func getVertex(index:Int)->Vector3D {
        return v[index];
    }
    
    
    /**
        Projects this polygon onto the view window.
    */
    func project(view:ViewWindow) {
        
        for i in 0...(numVertices - 1) {
            
            view.project(v[i]);
        }
    }
    
    /**
    Adds the specified transform to this vector. This vector
    is first rotated, then translated.
    */
    func add(xform:Transform3D) {
        
        for i in 0...(numVertices - 1){
            v[i].add(xform)
        }

    }
    
    
    /**
    Subtracts the specified transform to this vector. This
    vector is translated, then rotated.
    */
    func subtract(xform:Transform3D) {
        
        for i in 0...(numVertices - 1){
            v[i].subtract(xform)
        }
    }
    
    /**
        Calculates the unit-vector normal of this polygon.
        This method uses the first, second, and third vertices
        to calculate the normal, so if these vertices are
        collinear, this method will not work.
        Use setNormal() to explicitly set the normal.
        This method uses static objects in the Polygon3D class
        for calculations, so this method is not thread-safe across
        all instances of Polygon3D.
    */
    func calcNormal()->Vector3D {
        
        var temp1 = Vector3D(x: 0, y: 0, z: 0)
        var temp2 = Vector3D(x: 0, y: 0, z: 0)
        temp1.setTo(v[2]);
        temp1.subtract(v[1]);
        temp2.setTo(v[0]);
        temp2.subtract(v[1]);
        normal_.setToCrossProduct(temp1, v: temp2);
        normal_.normalize();
        return normal_;
    }
    
    /**
    Gets the normal of this polygon. Use calcNormal() if
    any vertices have changed.
    */
    var normal:Vector3D {
        get {
            return normal_;
        }
        set {
            normal.setTo(newValue)
        }
    }
    


    
}