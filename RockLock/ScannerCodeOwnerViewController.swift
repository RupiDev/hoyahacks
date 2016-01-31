//
//  ScannerCodeOwnerViewController.swift
//  RockLock
//
//  Created by Rupin Bhalla on 1/30/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerCodeOwnerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var input: AVCaptureDeviceInput?
    var code: String!
    var labelBool = false;
    
    @IBOutlet weak var addButtonLabel: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error:NSError?
        do {
            input = try AVCaptureDeviceInput(device: captureDevice) as AVCaptureDeviceInput
            
            
        } catch let error as NSError{
            print("\(error.localizedDescription)")
        }
        
        // initialize the captureSession
        captureSession = AVCaptureSession();
        
        // Set the input device on the capture session
        captureSession?.addInput(input as! AVCaptureInput)
        
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession?.startRunning()
        
        // Move the message label to the top view
        view.bringSubviewToFront(messageLabel);
        view.bringSubviewToFront(addButtonLabel)
        
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
        

        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0
        {
            qrCodeFrameView?.frame = CGRectZero
            if(!labelBool)
            {
                messageLabel.text = "No QR code is detected"
            }
            else
            {
                messageLabel.text = "You have been added"
            }
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil
            {
                messageLabel.text = metadataObj.stringValue
                code = metadataObj.stringValue;
                labelBool = true;
                
            }
            
            /*if(labelBool)
            {
                messageLabel.text = code;
            }*/
            

        }
    }
    
    @IBAction func AddOwnerCode(sender: AnyObject)
    {
        
        labelBool = true;
        
        let defaults = NSUserDefaults.standardUserDefaults();
        let aUI: String = defaults.objectForKey("permanentArduinoId") as! String
        let phoneId: String = code as String
        
        let url = NSURL(string:"http://1f68bb46.ngrok.io/addphone/\(aUI)/\(phoneId)")
        
        let newurl = NSMutableURLRequest(URL:url!)
        var session = NSURLSession.sharedSession()
        newurl.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(newurl, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            self.messageLabel.text = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            
            
            
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            
        }

        
        
        
        
        //defaults.setObject(arduinoID, forKey: "permanentArduinoId");
        
        
        //defaults.setObject(blo, forKey: "permanentPhoneId")
        
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
