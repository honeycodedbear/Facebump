//
//  ProfilePage.swift
//  Facebump
//
//  Created by Max Rogers on 4/25/15.
//  Copyright (c) 2015 Max Rogers. All rights reserved.
//

import UIKit

private let _sharedInstance = ProfilePage()

class ProfilePage: UIViewController{
    class var sharedInstance : ProfilePage{
        return _sharedInstance
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var label = UILabel(frame: CGRect(x:0,y:0,width:400,height:100))
        label.text = "Welcome to Facebump."
        self.view.addSubview(label)
        var label2 = UILabel(frame: CGRect(x:0,y:50,width:400,height:100))
        label2.text = "The easiest way to exchange contact information in the real world."
        self.view.addSubview(label2)
        
        var nameField = UITextField(frame: CGRect(x:0,y:100,width:400,height:100))
        nameField.text = "Your Full Name?"
        nameField.backgroundColor = UIColor(white: 100, alpha: 0.5)
        self.view.addSubview(nameField)
        
        var numberField = UITextField(frame: CGRect(x:0,y:200,width:400,height:100))
        numberField.text = "Your Number?"
        numberField.backgroundColor = UIColor(white: 100, alpha: 0.5)
        self.view.addSubview(numberField)
        
        var emailField = UITextField(frame: CGRect(x:0,y:300,width:400,height:100))
        emailField.text = "Your Email?"
        emailField.backgroundColor = UIColor(white: 100, alpha: 0.5)
        self.view.addSubview(emailField)
    }
}