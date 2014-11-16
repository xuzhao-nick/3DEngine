//
//  Scan.swift
//  3DEngine
//
//  Created by Xu Zhao on 20/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation


/**
    A horizontal scan line.
*/
class Scan {
    
    var left:Int = 0
    var right:Int = 0
    
    /**
        Sets the left and right boundaries for this scan if
        the x value is outside the current boundary.
    */
    func setBoundary(x:Int) {
    
        if x < left {
            left = x;
        }
        if x - 1 > right {
            right = x-1;
        }
    }
    
    
    /**
        Clears this scan line.
    */
    func clear() {
    
        left = Int.max
        right = Int.min
    }
    
    
    /**
        Determines if this scan is valid (if left <= right).
    */
    func isValid()->Bool {
        
        return left <= right
        
    }
    
    
    /**
        Set this scan.
    */
    func setTo(left:Int, right:Int) {
        
        self.left = left
        self.right = right
        
    }
    
    
    /**
        Checks if this scan is equal to the specified values.
    */
    func equals(left:Int, right:Int)->Bool {
        
        return self.left == left && self.right == right
    }
}
