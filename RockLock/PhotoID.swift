//
//  PhotoID.swift
//  RockLock
//
//  Created by Rupin Bhalla on 1/30/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoID: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    @IBOutlet weak var photoIDImage: UIImageView!

    var qrCodeImage: CIImage!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let blo = UIDevice.currentDevice().identifierForVendor!.UUIDString;
        
        
        
        let data = blo.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
                
        let filter = CIFilter(name: "CIQRCodeGenerator")
            
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
        qrCodeImage = filter!.outputImage
            
        //qrCodeImage.image = UIImage(CIImage: qrCodeImage)
            
        photoIDImage.image = UIImage(CIImage: qrCodeImage)
            
        

        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
