//
//  OwnerRegisterIDViewController.swift
//  RockLock
//
//  Created by Rupin Bhalla on 1/30/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit


class OwnerRegisterIDViewController: UIViewController, UITextFieldDelegate
{

    @IBOutlet weak var arduinoIDTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitIDAction(sender: AnyObject)
    {
        let arduinoID: String = arduinoIDTextField.text!;
        
        
        let blo: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let url = NSURL(string:"http://1f68bb46.ngrok.io/register/\(arduinoID)/\(blo)")
        
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setObject(arduinoID, forKey: "permanentArduinoId");
        defaults.setObject(blo, forKey: "permanentPhoneId")
        
        //let url = NSURL(string:"http://1f68bb46.ngrok.io/register/19284819/CCF77445-1AA7-4536-8E50-7784F17C78AF")
        
        let newurl = NSMutableURLRequest(URL:url!)
        var session = NSURLSession.sharedSession()
        newurl.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(newurl, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            self.resultLabel.text = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            
            
            
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true);
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
