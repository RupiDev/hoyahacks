//
//  UnlockDoorController.swift
//  RockLock
//
//  Created by Rupin Bhalla on 1/30/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class UnlockDoorController: UIViewController
{

    @IBOutlet weak var unlockDoorButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unlockDoorAction(sender: AnyObject)
    {
        let defaults = NSUserDefaults.standardUserDefaults();
        let aUI: String = defaults.objectForKey("permanentArduinoId") as! String
        let phoneId: String = defaults.objectForKey("permanentPhoneId") as! String
        
        let url = NSURL(string:"http://1f68bb46.ngrok.io/unlock/\(aUI)/\(phoneId)")
        
        let newurl = NSMutableURLRequest(URL:url!)
        var session = NSURLSession.sharedSession()
        newurl.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(newurl, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            //self.messageLabel.text = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            
            
            
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            
        }

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
