//
//  Polygon3D.swift
//  3DEngine
//
//  Created by Xu Zhao on 19/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation


var temp1 = Vector3D(x: 0, y: 0, z: 0)
var temp2 = Vector3D(x: 0, y: 0, z: 0)
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
    
    /**
        Tests if this polygon is facing the specified location.
        This method uses static objects in the Polygon3D class
        for calculations, so this method is not thread-safe across
        all instances of Polygon3D.
    */
    func isFacing(vector3D:Vector3D)->Bool {
        
        temp1.setTo(vector3D);
        temp1.subtract(v[0]);
        return (normal.getDotProduct(temp1) >= 0)
        
    }
    
    /**
        Clips this polygon so that all vertices are in front of
        the clip plane, clipZ (in other words, all vertices
        have z <= clipZ).
        The value of clipZ should not be 0, as this causes
        divide-by-zero problems.
        Returns true if the polygon is at least partially in
        front of the clip plane.
    */
    func clip(clipZ:Float)->Bool {
        //ensureCapacity(numVertices * 3)
    
        var isCompletelyHidden = true
    
        // insert vertices so all edges are either completely
        // in front of or behind the clip plane
        for (var i = 0; i < numVertices; i++) {
            var next:Int = (i + 1) % numVertices
            var v1:Vector3D = v[i]
            var v2:Vector3D = v[next]
            if (v1.z < clipZ) {
                isCompletelyHidden = false
            }
            // ensure v1.z < v2.z
            if (v1.z > v2.z) {
                var temp:Vector3D = v1
                v1 = v2
                v2 = temp
            }
            if (v1.z < clipZ && v2.z > clipZ) {
                var scale:Float = (clipZ-v1.z) / (v2.z - v1.z)
                insertVertex(next,x: v1.x + scale * (v2.x - v1.x) ,y: v1.y + scale * (v2.y - v1.y),z: clipZ)
                // skip the vertex we just created
                i++
            }
        }
    
        if (isCompletelyHidden) {
            return false
        }
    
        // delete all vertices that have z > clipZ
        for (var i = numVertices - 1; i >= 0; i--) {
            if (v[i].z > clipZ) {
                deleteVertex(i)
            }
        }
    
        return (numVertices >= 3)
    }
    
    
    /**
        Inserts a new vertex at the specified index.
    */
    func insertVertex(index:Int, x:Float, y:Float,z:Float)
    {
        var newVertex:Vector3D = Vector3D(x: x, y: y, z: z)
        v.insert(newVertex, atIndex: index)
        numVertices++;
    }
    
    
    /**
        Delete the vertex at the specified index.
    */
    func deleteVertex(index:Int) {
        v.removeAtIndex(index)
        numVertices--;
    }


    
}