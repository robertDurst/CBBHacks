//
//  ViewController.swift
//  test
//
//  Created by Coder on 1/30/16.
//  Copyright © 2016 BobbyDandJMan. All rights reserved.
//

import UIKit
import Parse
import UIColor_Hex_Swift

class PartyProfileViewController: UIViewController {
    //Initialization of things
    let scrollView = UIScrollView()
    var partyImage = UIImageView()
    var partyTitle = UILabel()
    var hostTitle = UILabel()
    var partyTheme = UILabel()
    var location = UILabel()
    var timeStart = UILabel()
    var descriptionParty = UITextView()
    var guestLimit = UILabel()
    var fundsRequested = UILabel()
    var guestLimitValue = UILabel()
    var fundsRequestedValue = UILabel()
    var rsvpButton = UIButton()
    var partyDetails:PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialization things
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .whiteColor()
        self.view = self.scrollView
        self.scrollView.contentSize = CGSize(width:width, height: 500)
        scrollView.backgroundColor = .blackColor()
        view.backgroundColor = .blackColor()
        
        //Create the party image
        let image : UIImage = UIImage(named:"defaultPhoto")!
        partyImage = UIImageView(frame:CGRectMake(5, 5, width/3, width/3))
        partyImage.image = image
        self.view.addSubview(partyImage)
        
        //Create the party title
        partyTitle = UILabel(frame: CGRectMake(width/3+5,5, (width*2/3)-5, 44))
        partyTitle.backgroundColor = .blackColor()
        partyTitle.textColor = .whiteColor()
        partyTitle.text = partyDetails.valueForKey("Party_Name") as! String!
        partyTitle.textAlignment = .Center
        partyTitle.font = UIFont(name: partyTitle.font.fontName, size: 22)
        self.view.addSubview(partyTitle)
        
        //Create the party theme
        partyTheme = UILabel(frame: CGRectMake(width/3+5,40, (width*2/3)-5, 44))
        partyTheme.backgroundColor = .blackColor()
        partyTheme.textColor = .whiteColor()
        partyTheme.text = "Theme: \(partyDetails.valueForKey("Theme") as! String!)"
        partyTheme.textAlignment = .Center
        partyTheme.font = UIFont(name: partyTheme.font.fontName, size: 17)
        self.view.addSubview(partyTheme)
        
        //Create the host name title
        hostTitle = UILabel(frame: CGRectMake(width/3+5,70, (width*2/3)-5, 35))
        hostTitle.backgroundColor = .blackColor()
        hostTitle.textColor = .whiteColor()
        hostTitle.text = "Hosted by \(partyDetails.valueForKey("Host_Name") as! String!)"
        hostTitle.textAlignment = .Center
        hostTitle.font = UIFont(name: hostTitle.font.fontName, size: 12)
        self.view.addSubview(hostTitle)
        
        //Create the location label
        location = UILabel(frame: CGRectMake(5,width/3+5, width/2, 35))
        location.backgroundColor = .blackColor()
        location.textColor = .whiteColor()
        location.text = "Location: \(partyDetails.valueForKey("Location") as! String!)"
        location.font = UIFont(name: location.font.fontName, size: 12)
        self.view.addSubview(location)
        
        //Create the time label
        timeStart = UILabel(frame: CGRectMake((width/2)+5,width/3+5, (width/2)-10, 35))
        timeStart.backgroundColor = .blackColor()
        timeStart.textColor = .whiteColor()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "US_en")
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        timeStart.text = "\(partyDetails.valueForKey("Date") as! NSDate!)"
        timeStart.textAlignment = .Right
        timeStart.font = UIFont(name: timeStart.font.fontName, size: 12)
        self.view.addSubview(timeStart)
        
        //Create the Description
        descriptionParty = UITextView(frame:CGRectMake(5, (width/3)+5+40, width-10, 200))
        descriptionParty.backgroundColor = .blackColor()
        descriptionParty.layer.borderColor = UIColor.whiteColor().CGColor
        descriptionParty.layer.borderWidth = 2
        descriptionParty.text = partyDetails.valueForKey("Description") as! String!
        descriptionParty.textColor = .whiteColor()
        descriptionParty.font = UIFont(name: descriptionParty.font!.fontName, size: 12)
        descriptionParty.userInteractionEnabled = false
        self.view.addSubview(descriptionParty)
        
        //Create the guests label
        guestLimit = UILabel(frame: CGRectMake(5,(width/3)+5+40+205, (width/2)-10, 35))
        guestLimit.backgroundColor = .blackColor()
        guestLimit.textColor = .whiteColor()
        var guestCount = partyDetails.valueForKey("Guests")?.count
        if (guestCount == nil) {
            guestCount = 0
        }
        guestLimit.text = "Guests: \(guestCount!)"
        guestLimit.font = UIFont(name: guestLimit.font.fontName, size: 14)
        self.view.addSubview(guestLimit)
        
        //Create the funds label
        fundsRequested = UILabel(frame: CGRectMake(5,(width/3)+5+40+205+40, (width/2)-10, 35))
        fundsRequested.backgroundColor = .blackColor()
        fundsRequested.textColor = .whiteColor()
        fundsRequested.text = "Requested: $\(partyDetails.valueForKey("Funding_Goal") as! Int!)"
        fundsRequested.font = UIFont(name: fundsRequested.font.fontName, size: 14)
        self.view.addSubview(fundsRequested)
        
        //Create the guests value label
        guestLimitValue = UILabel(frame: CGRectMake((width/2)+5,(width/3)+5+40+205, (width/2)-10, 35))
        guestLimitValue.backgroundColor = .blackColor()
        guestLimitValue.textColor = .whiteColor()
        guestLimitValue.text = "Guest Limit: \(partyDetails.valueForKey("Guest_Limit") as! Int!)"
        guestLimitValue.font = UIFont(name: guestLimitValue.font.fontName, size: 14)
        guestLimitValue.textAlignment = .Right
        self.view.addSubview(guestLimitValue)
        
        //Create the funds value label
        fundsRequestedValue = UILabel(frame: CGRectMake((width/2)+5,(width/3)+5+40+205+40, (width/2)-10, 35))
        fundsRequestedValue.backgroundColor = .blackColor()
        fundsRequestedValue.textColor = .whiteColor()
        fundsRequestedValue.text = "Funding Achieved: $\(guestCount! * 5)"
        fundsRequestedValue.font = UIFont(name: fundsRequestedValue.font.fontName, size: 14)
        fundsRequestedValue.textAlignment = .Right
        self.view.addSubview(fundsRequestedValue)
        
        self.rsvpButton = UIButton(frame: CGRectMake(5,height-120, width-10, 44.0))
        
        self.rsvpButton.backgroundColor = .whiteColor()
        self.rsvpButton.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        self.rsvpButton.layer.borderColor = UIColor.blackColor().CGColor
        self.rsvpButton.layer.borderWidth = 2
        self.rsvpButton.userInteractionEnabled = true
        self.rsvpButton.addTarget(self, action: "rsvpButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.rsvpButton.setTitle("Fetching...", forState: UIControlState.Normal)
        self.view.addSubview(self.rsvpButton)
        
        
        //Create the rsvp button
        let query = PFQuery(className:"Party")
        query.whereKey("Guests", equalTo: UIDevice.currentDevice().identifierForVendor!.UUIDString)
        query.whereKey("Keyword", equalTo:partyDetails.objectForKey("Keyword")!)
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if (error == nil) {
                if (object?.count == 0) {
                    self.rsvpButton.setTitle("RSVP: $5", forState: UIControlState.Normal)
                }
                else {
                    self.rsvpButton.backgroundColor = UIColor(rgba: "#006400") // Solid color
                    self.rsvpButton.setTitle("Already Paid! Continue to Verifier", forState: UIControlState.Normal)
                }
            }
            else {
                print(error)
            }
            
        }
        
    }

    func rsvpButtonAction(Sender:UIButton){
        //
        // make them pay
        //
        let query = PFQuery(className:"Party")
        query.getObjectInBackgroundWithId(self.partyDetails.valueForKey("objectId") as! String!) {
            (object, error) -> Void in
            if error != nil {
                print("ERROR")
                print(error)
            } else {
                if let object = object {
                    
                    object.addUniqueObject(UIDevice.currentDevice().identifierForVendor!.UUIDString, forKey: "Guests")
                }
                object!.saveInBackground()
            }
        }
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("verificationViewController") as! VerificationViewController
        vc.partyDetails = self.partyDetails
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

