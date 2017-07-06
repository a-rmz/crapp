//
//  ViewController.swift
//  CR-APP
//
//  Created by Saúl Ponce on 7/4/17.
//  Copyright © 2017 Saúl Ponce. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, SwiftyDrawViewDelegate {
    
    @IBOutlet weak var recognizedText: UITextField!
    @IBOutlet weak var drawingView: UIView!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewToDraw = SwiftyDrawView(frame: self.view.frame)
        self.drawingView.addSubview(viewToDraw)
        
        viewToDraw.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        getLetterFromImage()
        
        let canvas = self.drawingView.subviews.first! as! SwiftyDrawView
        canvas.clearCanvas()
    }
    
    func getLetterFromImage() {
        let image = self.imageWithView(view: self.drawingView)
        let imageData = UIImagePNGRepresentation(image)
        let base64Image = imageData!.base64EncodedString(options: .lineLength64Characters)
        requestWithImage(base64Image: base64Image)
    }
    
    func requestWithImage(base64Image: String) {
        let headers = [
            "authorization": "Basic ZE9kYXFpOk4qZ2hAYm41NDIk",
            "content-type": "application/json",
            "cache-control": "no-cache",
            "postman-token": "b00f5c78-31f8-e906-cedb-e032df54f80e"
        ]
        let parameters = ["image": base64Image]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://a0bc4589.ngrok.io/api")! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("\(error!)")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("\(httpResponse!)")
            }
        })
        
        dataTask.resume()
    }
    
    @IBAction func tap(_ sender: Any) {
        UIPasteboard.general.string = self.recognizedText.text
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

