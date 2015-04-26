//
//  ProfilePage.swift
//  Facebump
//
//  Created by Max Rogers on 4/25/15.
//  Copyright (c) 2015 Max Rogers. All rights reserved.
//

import UIKit
import SwiftAddressBook

private let _sharedInstance = ProfilePage()

class ProfilePage: UIViewController{
    var label = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var firstNameField = UITextField()
    var lastNameField = UITextField()
    var phoneField = UITextField()
    var emailField = UITextField()
    
    class var sharedInstance : ProfilePage{
        return _sharedInstance
    }
    
    func setUpLayout(){
        //Build the things
        
        label.text = "Welcome to Facebump."
        label.textAlignment = NSTextAlignment.Center
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label2.setTranslatesAutoresizingMaskIntoConstraints(false)
        label2.text = "The easiest way to exchange"
        label2.textAlignment = NSTextAlignment.Center
        
        label3.text = "contact information in the real world."
        label3.setTranslatesAutoresizingMaskIntoConstraints(false)
        label3.textAlignment = NSTextAlignment.Center
        
        firstNameField.placeholder = "Please Enter First Name"
        firstNameField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        lastNameField.placeholder = "Please Enter Last Name"
        lastNameField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        phoneField.placeholder = "Please Enter Phone Number"
        phoneField.setTranslatesAutoresizingMaskIntoConstraints(false)
        phoneField.keyboardType = UIKeyboardType.PhonePad
        
        emailField.placeholder = "Please Enter Your Email"
        emailField.setTranslatesAutoresizingMaskIntoConstraints(false)
        emailField.keyboardType = UIKeyboardType.EmailAddress
        
        var submitBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        submitBtn.frame = CGRectMake(100, 100, 100, 50)
        submitBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        submitBtn.setTitle("Create Profile", forState: UIControlState.Normal)
        submitBtn.addTarget(self, action: "createProfile:", forControlEvents: UIControlEvents.TouchUpInside)

        //Add the things
        self.view.addSubview(label)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(firstNameField)
        self.view.addSubview(lastNameField)
        self.view.addSubview(phoneField)
        self.view.addSubview(emailField)
        self.view.addSubview(submitBtn)
        
        //Resize the things
        self.view.addConstraint(NSLayoutConstraint(
                item:label,
                attribute:NSLayoutAttribute.Width,
                relatedBy:NSLayoutRelation.Equal,
                toItem:self.view,
                attribute:NSLayoutAttribute.Width,
                multiplier:1.0,
                constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:label2,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:1.0,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:label3,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:1.0,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Top,
            multiplier:1.0,
            constant:20))
        self.view.addConstraint(NSLayoutConstraint(
            item:label2,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:label,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:label3,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:label2,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0))
        
        //fields
        self.view.addConstraint(NSLayoutConstraint(
            item:firstNameField,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.8,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:firstNameField,
            attribute:NSLayoutAttribute.Leading,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Leading,
            multiplier:1.0,
            constant:20))
        self.view.addConstraint(NSLayoutConstraint(
            item:firstNameField,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:label3,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item:lastNameField,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.8,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:lastNameField,
            attribute:NSLayoutAttribute.Leading,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Leading,
            multiplier:1.0,
            constant:20))
        self.view.addConstraint(NSLayoutConstraint(
            item:lastNameField,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:firstNameField,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item:phoneField,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.8,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:phoneField,
            attribute:NSLayoutAttribute.Leading,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Leading,
            multiplier:1.0,
            constant:20))
        self.view.addConstraint(NSLayoutConstraint(
            item:phoneField,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:lastNameField,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:emailField,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.8,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:emailField,
            attribute:NSLayoutAttribute.Leading,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Leading,
            multiplier:1.0,
            constant:20))
        self.view.addConstraint(NSLayoutConstraint(
            item:emailField,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:phoneField,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0))
        
        //buttons
        self.view.addConstraint(NSLayoutConstraint(
            item:submitBtn,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:emailField,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:submitBtn,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:1.0,
            constant:0))
    }
        
    func createProfile(sender:UIButton!){
        println("Button Click")
        let defaults = NSUserDefaults.standardUserDefaults()
        let dict : [NSObject : AnyObject]  = ["firstName": firstNameField.text, "lastName": lastNameField.text, "email": emailField.text, "phone": phoneField.text]
        defaults.setObject(dict, forKey: "profile")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
}