//
//  ContainerController.swift
//  Facebump
//
//  Created by Max Rogers on 4/22/15.
//  Copyright (c) 2015 Max Rogers. All rights reserved.
//

//Step 1. Compile QR or other codes
//Type of Codes https://developer.apple.com/library/prerelease/ios/documentation/AVFoundation/Reference/AVMetadataMachineReadableCodeObject_Class/index.html#//apple_ref/doc/constant_group/Machine_Readable_Object_Types
//Step 2. Access front facing camera
//Step 3. Scan the QR or other codes
//Step 4. Need to acess internal contact
//Step 5. Facebook and other intergration



import Foundation
import UIKit
import RSBarcodes_Swift
import AVFoundation

private let _containerControllerInstance = ContainerController()

class ContainerController: UIViewController {
    
    class var sharedInstance : ContainerController{
        return _containerControllerInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var child = UIView(frame: CGRect(x:0,y:0,width:100,height:100))
        child.backgroundColor = UIColor.redColor()
        self.view.addSubview(child)
        
        var image = RSUnifiedCodeGenerator.shared.generateCode("MAXROGERS 9177763154 MAXROGERS90@GMAIL.COM", machineReadableCodeObjectType: AVMetadataObjectTypeQRCode)
        var codeView = UIImageView(image: image)
        codeView.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
        self.view.addSubview(codeView)
    }
}