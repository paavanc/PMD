//
//  CheckIn.swift
//  PeopleMakingADifference
//
//  Created by Brian Tan on 10/26/14.
//  Copyright (c) 2014 Brian Tan. All rights reserved.
//

import UIKit
import Parse

class CheckIn: UIViewController
{
   
   @IBOutlet weak var emailTextField: UITextField!
   @IBOutlet weak var roomcodeTextField: UITextField!
   @IBOutlet weak var welcomeMessage: UILabel!
   @IBOutlet weak var timeLabel: UILabel!


   override func viewDidLoad()
   {
      super.viewDidLoad()

    
   }
   
   //Exits keyboard on "done" in Room Code textfield
   
   @IBAction func roomTextFieldEditingDidEnd(sender: AnyObject)
   {
      (sender as UITextField).resignFirstResponder();
   
   }
   
   //Exits keyboard on "done" in Email textfield
   
   @IBAction func emailTextFieldEditingDidEnd(sender: AnyObject)
   {
      //cast the sender to a UITextField b/c thats what we are working with
      (sender as UITextField).resignFirstResponder();
   }
   
   func getCurrentTime() -> String
   {
      //create variables that hold the current date's info
      let currentDate = NSDate();
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: currentDate)
      var hour = components.hour
      let minute = components.minute
      
      var timeOfDay = "AM"
      if(hour > 11)
      {
         //Make it a 12 Hour Time display
         if(hour > 12)
         {
            hour = hour - 12;
         }
         
         //If the hour is past 12, change timeofDay to PM
         timeOfDay = " PM"
      }
      //24 hour clock displays 12 AM as 0:00, so change to display 12:00
      if(hour == 0)
      {
         hour = 12;
      }
      
      var hourText = String(hour)
      var minText = String(minute)
      if(minute < 10)
      {
         minText = "0" + minText
      }
      
      var checkedInAt = hourText + ":" + minText + timeOfDay
      return checkedInAt
   
   }
   
   
   //Submit button found on Check In page
   @IBAction func checkInSubmit(sender: AnyObject)
   {
      //check the Room Code
        var query = PFQuery(className:"SchoolCleaning")
        query.whereKey("roomCode", equalTo:roomcodeTextField.text)
        query.getFirstObjectInBackgroundWithBlock 
        {
            (object: PFObject!, error: NSError!) -> Void in
            //IF THE ROOM CODE MATCHES
            if object != nil 
            {
               
                //check if the email exists
                var queryTwo = PFQuery(className:"SchoolCleaning")
                queryTwo.whereKey("Email", equalTo:self.emailTextField.text)
                queryTwo.getFirstObjectInBackgroundWithBlock 
                {
                    (object: PFObject!, error: NSError!) -> Void in
                    //THE EMAIL EXISTS
                    if object != nil 
                    {
                       
                       	// SAVE THE ARRIVAL TIME TO DATABASE
                        var timeUpdate = PFObject(className:"SchoolCleaning")
                        var query = PFQuery(className:"SchoolCleaning")
                        
                        query.getObjectInBackgroundWithId(object.objectId) 
                        {
                            (timeUpdate: PFObject!, error: NSError!) -> Void in
                            if error != nil 
                            {
                                NSLog("%@", error)
                            } 
                            else 
                            {
                                timeUpdate["ArrivalTime"]=NSDate()
                                var apple = NSDate()

                                println("\(apple)")
                                timeUpdate.saveEventually()
                                
                               
                            }
                   	 	}
                     
                        //get tabBarController if there is one, and then change the view to index 1 (which is the second view controller
                        self.tabBarController?.selectedIndex = 1
            
                  	   //Pulls out Volunteers Info
                  	   var vName = (object["Name"] as String)
                  	   var eName = "PMD"
                  	   var cTime = self.getCurrentTime()
                  	   var sBegin = (object["shiftStarts"] as String)
                  	   var sEnd = (object["shiftEnds"] as String)
                  	   var myTask  = (object["Assignment"] as String)
                  	   var roomNum = (object["Room"] as String)
                  	   var tSize = (object["tShirtSize"] as String)
                  	   var lunch = (object["Lunch"] as String)
         
                  	   //This code will run the displayInfo func
                  	   (self.tabBarController?.viewControllers?[1] as MyAssignment).displayInfo(vName, eName: eName, ciTime: cTime, sSTime: sBegin, sETime: sEnd, vTask: myTask, rAss: roomNum, sSize: tSize, lunch: lunch)
         
                  	  self.welcomeMessage.text = "Enjoy the event!"
                        
                    }
                    //IF EMAIL DOESNT EXIST 
                    else
                    {
                        NSLog(object.objectId)
                       
                        self.welcomeMessage.text="Incorrect email address."
                       
                    }
            	}
            }
            //IF ROOM CODE DOESNT MATCH 
            else 
            {   
                self.welcomeMessage.text="Incorrect room code."  
            }
           
         }
      }
   
   
      
}
