//
//  HousesViewController.swift
//  RockLock
//
//  Created by Rupin Bhalla on 1/30/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit



class HousesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    var allUsers: [String]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let defaults = NSUserDefaults.standardUserDefaults();
        let arduinoId: String  =  defaults.objectForKey("permanentArduinoId") as! String
        let phoneId: String = defaults.objectForKey("permanentPhoneId") as! String
        
        let url = NSURL(string:"http://1f68bb46.ngrok.io/phones/\(arduinoId)")
        
        let request = NSURLRequest(URL: url!);
        let newSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        
       
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
        
            do
            {
                var jsonObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
        
                let users = (jsonObject as! NSDictionary)["people"] as! [String]
                
                self.allUsers = users;
                
                print(self.allUsers[0])
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
        
        if allUsers == nil
        {
            return 0;
        }
        else
        {
            return allUsers.count;

        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UserCell
        
        if(allUsers != nil)
        {
            cell.userLabel.text = allUsers[indexPath.row]
            
        }
        return cell;
        
        
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            
            allUsers.removeAtIndex(indexPath.row);
            
            
            tableView.reloadData();
            
            
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
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
