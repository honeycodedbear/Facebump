//
//  ScanningPage.swift
//  Facebump
//
//  Created by Max Rogers on 4/25/15.
//  Copyright (c) 2015 Max Rogers. All rights reserved.
//

import AVFoundation
import UIKit
import SwiftAddressBook
import RSBarcodes_Swift
import QRCode
import AudioToolbox

//Fixing NSURL to turn the Query string into a usable Dictioanry
extension NSURL
{
    @objc var queryDictionary:[String: [String]]? {
        get {
            if let query = self.query {
                var dictionary = [String: [String]]()
                
                for keyValueString in query.componentsSeparatedByString("&") {
                    var parts = keyValueString.componentsSeparatedByString("=")
                    if parts.count < 2 { continue; }
                    
                    var key = parts[0].stringByRemovingPercentEncoding!
                    var value = parts[1].stringByRemovingPercentEncoding!
                    
                    var values = dictionary[key] ?? [String]()
                    values.append(value)
                    dictionary[key] = values
                }
                
                return dictionary
            }
            
            return nil
        }
    }
}

private let _sharedInstance = ScanningPage()

class ScanningPage: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //@IBOutlet weak var messageLabel:UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    class var sharedInstance : ScanningPage{
        return _sharedInstance
    }
    
    // Added to support different barcodes
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        var videoDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        var captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        for device in videoDevices{
            let device = device as! AVCaptureDevice
            //THIS SAYS WHAT CAMERA TO USE .Front vs .Back
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device
                break
            }
        }
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
            // If any error occurs, simply log the description of it and don't continue any more.
            println("\(error?.localizedDescription)")
            return
        }
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        // Set the input device on the capture session.
        captureSession?.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = supportedBarCodes
        
        
        // FOR TESTING PROPOSES
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        //view.layer.addSublayer(videoPreviewLayer)
        
        
        // Start video capture.
        captureSession?.startRunning()
        
        // Move the message label to the top view
        //view.bringSubviewToFront(messageLabel)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
        addQRCodeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // this is reading the data from the qr code
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            //messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // THIS IS THE TRIGGER CONDITION WHEN WE FIND A QR CODE
        // Here we use filter method to check if the type of metadataObj is supported
        // Instead of hardcoding the AVMetadataObjectTypeQRCode, we check if the type
        // can be found in the array of supported bar codes.
        if supportedBarCodes.filter({ $0 == metadataObj.type }).count > 0 {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            //THIS DRAWS THE GREEN SQUARE AROUND THE QR CODE
            //qrCodeFrameView?.frame = barCodeObject.bounds
            
            if metadataObj.stringValue != nil {
                //messageLabel.text = metadataObj.stringValue
                launchApp(metadataObj.stringValue)
            }
        }
    }
    
    //This is the alert prompt
    func launchApp(decodedURL: String) {
        //Want to alert them with a vibrate
        //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        //Doesn't appear to work :(
        var resultString = ""
        var url = NSURL(string: decodedURL)
        let dict = url!.queryDictionary
        let firstName = dict?["firstName"]?.first
        let lastName = dict?["lastName"]?.first
        let phoneNumber = dict?["phoneNumber"]?.first
        let email = dict?["email"]?.first
        resultString = "Firstname: \(firstName!),\n Lastname: \(lastName!),\n PhoneNumber: \(phoneNumber!),\n Email: \(email!)"
        
        let alertPrompt = UIAlertController(title: "New Contact Found", message: "Would you like to add?\n \(resultString)", preferredStyle: .ActionSheet)
        let confirmAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            println("Save Contact")
            // Testing SwiftAddressBook
            swiftAddressBook?.requestAccessWithCompletion({ (success, error) -> Void in
                if success {
                    //do something with swiftAddressBook
                    var person = SwiftAddressBookPerson.create()
                    person.firstName = firstName
                    person.lastName = lastName
                    var new_email = MultivalueEntry(value: email!, label: "email", id: 0)
                    person.emails = [new_email]
                    var phone = MultivalueEntry(value: phoneNumber!, label: "phone", id: 0)
                    person.emails = [phone]
                    swiftAddressBook?.addRecord(person)
                    swiftAddressBook?.save()
                }else{
                    
                }
            })

        })
        let cancelAction = UIAlertAction(title: "Ignore", style: UIAlertActionStyle.Cancel, handler: nil)

        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)

        self.presentViewController(alertPrompt, animated: true, completion: nil)
    }

    //Our User's QR Code View
    func addQRCodeView(){
        var qrCode = QRCode("http://maxrogers.me?firstName=Max&lastName=Rogers")
        qrCode?.size = CGSize(width: 350, height:350)
        var codeView = UIImageView(image: qrCode?.image)
        self.view.addSubview(codeView)
        codeView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //Now Resize with Autolayout
        self.view.addConstraint(NSLayoutConstraint(
            item:codeView,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.9,
            constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:codeView,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Top,
            multiplier:1.0,
            constant:20))
        self.view.addConstraint(NSLayoutConstraint(
            item: codeView,
            attribute:NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))

    }
    
}
