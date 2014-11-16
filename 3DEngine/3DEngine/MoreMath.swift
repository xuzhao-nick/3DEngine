//
//  MoreMath.swift
//  3DEngine
//
//  Created by Xu Zhao on 16/11/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation

/**
    The MoreMath class provides functions contained some math functions
*/
class MoreMath {
    
    
    /**
        Faster ceil function to convert a float to an int.
        Contrary to the java.lang.Math ceil function, this
        function takes a float as an argument, returns an int
        instead of a double, and does not consider special cases.
    */
    class func ceil(f:Float)->Int {
        if (f > 0) {
            return Int(f) + 1
        } else {
            return Int(f)
        }
    }
    
    
    /**
        Faster floor function to convert a float to an int.
        Contrary to the java.lang.Math floor function, this
        function takes a float as an argument, returns an int
        instead of a double, and does not consider special cases.
    */
    class func floor(f:Float)->Int {
        if (f >= 0) {
            return Int(f)
        } else {
            return Int(f) - 1
        }
    }
    
    
    /**
    Returns true if the specified number is a power of 2.
    */
    class func isPowerOfTwo(n:Int)->Bool {
        return ((n & (n-1)) == 0)
    }
    
    
    /**
        Gets the number of "on" bits in an integer.
    */
    class func getBitCount(n:Int)->Int {
        var count = 0
        var num:Int = n
        while (num > 0) {
            count += (num & 1)
            num >>= 1
        }
        return count
    }
}
