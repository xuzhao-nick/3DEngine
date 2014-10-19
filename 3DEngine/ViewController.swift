//
//  ViewController.swift
//  3DEngine
//
//  Created by Xu Zhao on 18/10/14.
//  Copyright (c) 2014 Xu Zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!
    
    let ratio:Float = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        // Something cool
        // rotate around the y-axis
        drawView.treeTransform.rotateAngleY(0.002 * ratio)
        drawView.setNeedsDisplay()
    }
    
    @IBAction func zoomInButtonPressed(sender: UIButton) {
        
        drawView.treeTransform.location.z += 0.5 * ratio;
        drawView.setNeedsDisplay()
    }

    @IBAction func zoomOutButtonPressed(sender: UIButton) {
        
        drawView.treeTransform.location.z -= 0.5 * ratio;
        drawView.setNeedsDisplay()
    }
    

}

