//
//  ViewController.swift
//  CR-APP
//
//  Created by Saúl Ponce on 7/4/17.
//  Copyright © 2017 Saúl Ponce. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwiftyDrawViewDelegate {
    
    var timer = Timer()
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewToDraw = SwiftyDrawView(frame: self.view.frame)
        self.view.addSubview(viewToDraw)
        
        viewToDraw.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ImageViewController
        destination.imageToShow = self.image
        
    }
    
    func imageWithView (view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func scheduledTimerWithInterval() {
        if self.timer.isValid {
            self.timer.invalidate()
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.clearCanvas), userInfo: nil, repeats: false)

    }
    
    func clearCanvas() {
        self.image = self.imageWithView(view: self.view)
        let canvas = self.view.subviews[2] as! SwiftyDrawView
        canvas.clearCanvas()
        print("called")
    }
    
    func SwiftyDrawDidBeginDrawing(view: SwiftyDrawView) {
        // Called when the SwiftyDrawView detects touches have begun.
        
    }
    
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {
        // Called when the SwiftyDrawView detects touches are currrently occuring.
        // Will be called multiple times.
        
    }
    
    func SwiftyDrawDidFinishDrawing(view: SwiftyDrawView) {
        self.scheduledTimerWithInterval()
        // Called when the SwiftyDrawView detects touches have ended for the particular line segment
        
    }
    
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {
        
        // Called if SwiftyDrawView detects issues with the gesture recognizers and cancels the drawing
        
    }
}

