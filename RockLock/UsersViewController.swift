//
//  UsersViewController.swift
//  RockLock
//
//  Created by Rupin Bhalla on 1/30/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    var allHouses: [String]!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        //let blo: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        //let arduinoId: String  =  defaults.objectForKey("permanentArduinoId") as! String
        let phoneId: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let url = NSURL(string:"http://1f68bb46.ngrok.io/houses/\(phoneId)")
        
        let request = NSURLRequest(URL: url!);
        let newSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            do
            {
                var jsonObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                
                let houses = (jsonObject as! NSDictionary)["houses"] as! [String]
                
                self.allHouses = houses;
                
                print(self.allHouses[0])
                self.tableView.reloadData();
                
                
                
            }
            catch
            {
                print("Error")
            }
            
        }


        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if allHouses == nil
        {
            return 0;
        }
        else
        {
            return allHouses.count;
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HouseCell", forIndexPath: indexPath) as! HousesViewCell
        
        if(allHouses != nil)
        {
            cell.housesLabel.text = allHouses[indexPath.row];
            //cell.userLabel.text = allHouses[indexPath.row]
            
            
        }
        
        
        cell.selected = true;
        
        if(cell.selected)
        {
            //let defaults = NSUserDefaults.standardUserDefaults();
            //let aUI: String = defaults.objectForKey("permanentArduinoId") as! String
            
            let aUI = allHouses[indexPath.row];
            
            
            
            //let cell = sender as! UITableViewCell;
            //let indexPath = tableView.indexPathForCell(cell);
            
            //let aUI = allHouses[indexPath!.row];

            
            
            
            
            //let phoneId: String = defaults.objectForKey("permanentPhoneId") as! String
            
            let phoneId: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
            
            let url = NSURL(string:"http://1f68bb46.ngrok.io/unlock/\(aUI)/\(phoneId)")
            
            let newurl = NSMutableURLRequest(URL:url!)
            var session = NSURLSession.sharedSession()
            newurl.HTTPMethod = "POST"
            
            NSURLConnection.sendAsynchronousRequest(newurl, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                //self.messageLabel.text = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                
                
                
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                
            }
            
            print("Hello");
            
            

        }
        return cell;
        
        
        
    }
    
    
    
    
    
    @IBAction func UnlockAction(sender: AnyObject)
    {
        
        //if(tableView.cellForRowAtIndexPath(
        
        //let indexPath = tableView.indexPathForCell(cell)
        
        //let cell = sender as! UITableViewCell;
        //let indexPath = tableView.indexPathForCell(cell);
        
        //let aUI = allHouses[indexPath!.row];
        
        
        
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        
        //let aUI: String = defaults.objectForKey("permanentArduinoId") as! String
        let aUI: String = "19284819";
        
        
        //let phoneId: String = defaults.objectForKey("permanentPhoneId") as! String
        let phoneId: String = UIDevice.currentDevice().identifierForVendor!.UUIDString

        
        let url = NSURL(string:"http://1f68bb46.ngrok.io/unlock/\(aUI)/\(phoneId)")
        
        let newurl = NSMutableURLRequest(URL:url!)
        var session = NSURLSession.sharedSession()
        newurl.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(newurl, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            //self.messageLabel.text = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            
            
            
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            
        }
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
