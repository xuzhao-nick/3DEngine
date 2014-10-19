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

    
}