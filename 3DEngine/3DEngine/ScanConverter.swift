//
//  ScanConverter.swift
//  3DEngine
//
//  Created by Xu Zhao on 20/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import Foundation

class ScanConverter {
    
    let SCALE_BITS:Int = 16
    let SCALE:Int =  1 << 16
    let SCALE_MASK:Int = 15
    
    var view:ViewWindow = ViewWindow(left: 0, top: 0, width: 0, height: 0, angle: 0)
    var scans:[Scan] = [Scan]()
    var top:Int = 0
    var bottom:Int = 0
    
    
    
}