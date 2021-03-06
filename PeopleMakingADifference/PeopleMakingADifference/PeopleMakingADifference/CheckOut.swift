
import UIKit

class CheckOut: UIViewController
{

   @IBOutlet weak var checkoutEmailTextField: UITextField!
   @IBOutlet weak var checkoutRoomTextField: UITextField!
   @IBOutlet weak var checkOutConfirmLabel: UILabel!
   
   
    @IBOutlet weak var testMe: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }
   
    
    func getCurrentTimeDate() -> NSDate
    {
        return NSDate().dateByAddingTimeInterval(-1*60*60*5)
    }

    
   func getCurrentTimeString() -> String
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
   
   
   @IBAction func checkOutButtonPressed(sender: AnyObject)
   {
    
    //check the Room Code
    var query = PFQuery(className:"SchoolCleaning")
    query.whereKey("roomCode", equalTo:checkoutRoomTextField.text)
    query.getFirstObjectInBackgroundWithBlock
        {
            (object: PFObject!, error: NSError!) -> Void in
            //IF THE ROOM CODE MATCHES
            if object != nil
            {
                
                //check if the email exists
                var queryTwo = PFQuery(className:"SchoolCleaning")
                queryTwo.whereKey("Email", equalTo:self.checkoutEmailTextField.text)
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
                                        let signInTime=timeUpdate["ArrivalTime"]
                                        
                                        let calendar = NSCalendar.currentCalendar()
                                        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: signInTime as NSDate)
                                        var hour = components.hour
                                        let minute = components.minute
                                        
                                        
                                        timeUpdate["DepartureTime"]=self.getCurrentTimeDate()
                                        
                                        
                                        let calendarOut = NSCalendar.currentCalendar()
                                        let componentsOut = calendarOut.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: self.getCurrentTimeDate())
                                        var hourOut = componentsOut.hour
                                        var minuteOut = Double(componentsOut.minute)
                                        
                                        
                                        if minuteOut < 7{
                                            minuteOut=0
                                        }
                                        
                                         if (minuteOut > 7 && minuteOut < 15){
                                            minuteOut=15
                                        }
                                        
                                         if (minuteOut > 15 && minuteOut < 22){
                                            minuteOut = 15
                                        }
                                        
                                        if (minuteOut > 22 && minuteOut < 30){
                                            minuteOut = 30
                                        }
                                        
                                        if (minuteOut > 30 && minuteOut < 37){
                                            minuteOut = 30
                                        }
                                        if (minuteOut > 37 && minuteOut < 45){
                                            minuteOut = 45
                                        }
                                        if (minuteOut > 45 && minuteOut < 52){
                                            minuteOut = 45
                                        }
                                        
                                        if (minuteOut > 52 && minuteOut < 60){
                                            minuteOut = 0
                                            hourOut=hourOut + 1
                                        }


                                        
                                        
                        
                                    
                                        
                                        var TotalHours=hourOut-hour
                                        var TotalMins=Double(minuteOut) - Double(minute)
                                        var HourFraction=Double (TotalMins)*(1.0/60.0)
                                        
                                        
                                        
                              
                                        
                                    
                                        var TotalTimeNumber=Double(TotalHours) + HourFraction
                                        
                                         timeUpdate["TotalTime"]=TotalTimeNumber
                                        
                                        
                                        timeUpdate.saveEventually()
                                        
                                    }
                            }
                            
                            
                            //get tabBarController if there is one, and then change the view to index 1 (which is the second view controller
                            self.tabBarController?.selectedIndex = 0
                            
                          /*  //Pulls out Volunteers Info
                            var vName = "NaN"
                            var eName = "NaN"
                            var cTime = "NaN"
                            var sBegin = "NaN"
                            var sEnd = "NaN"
                            var myTask  = "NaN"
                            var roomNum = "NaN"
                            var tSize = "NaN"
                            var lunch = "NaN"
                            
                            //This code will run the displayInfo func
                            (self.tabBarController?.viewControllers?[1] as MyAssignment).displayInfo(vName, eName: eName, ciTime: cTime, sSTime: sBegin, sETime: sEnd, vTask: myTask, rAss: roomNum, sSize: tSize, lunch: lunch)
*/
                            
                            
                            self.checkOutConfirmLabel.text = "You Have Checked Out!"
                            
                        }
                            //IF EMAIL DOESNT EXIST
                        else
                        {
                            
                            self.checkOutConfirmLabel.text="Incorrect email address."
                            
                        }
                }
            }
                //IF ROOM CODE DOESNT MATCH 
            else 
            {   
                self.checkOutConfirmLabel.text="Incorrect room code."
            }
            
    }
    
    
    

}
}
