//
//  MyAssignment.swift
//  PeopleMakingADifference
//
//  Created by Brian Tan on 10/26/14.
//  Copyright (c) 2014 Brian Tan. All rights reserved.
//

import UIKit

class MyAssignment: UIViewController
{

   @IBOutlet weak var volunteerName: UILabel!
   @IBOutlet weak var eventName: UILabel!
   @IBOutlet weak var checkInTime: UILabel!
   @IBOutlet weak var shiftStartTime: UILabel!
   @IBOutlet weak var shiftEndTime: UILabel!
   @IBOutlet weak var volunteerTask: UILabel!
   @IBOutlet weak var roomAssignment: UILabel!
   @IBOutlet weak var tShirtSize: UILabel!
   @IBOutlet weak var lunchOrder: UILabel!
   
   var volName = "Brian Tan"
   var evName = "Blue Bowl"
   
   
   
   
  
   func displayInfo(vName: String, eName: String, ciTime: String, sSTime: String, sETime: String, vTask : String, rAss : String, sSize: String, lunch:String)
   {
      
      volunteerName.text = vName
      eventName.text = eName
      checkInTime.text = ciTime
      shiftStartTime.text = sSTime
      shiftEndTime.text = sETime
      volunteerTask.text = vTask
      roomAssignment.text = rAss
      tShirtSize.text = sSize
      lunchOrder.text = lunch
   }
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }
   
   /*
   if(checkedStatus == true)
      grab all info from database and post onto this page
   
   */


}

