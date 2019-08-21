//
//  CameraViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 12/24/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreML
import Shift

class CameraPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var titleLabel: ShiftMaskableLabel!
    @IBOutlet var cameraView: UIImageView!
    @IBOutlet var shootButton: UIButton!
    @IBOutlet var infoLabel: UITextView!
    @IBOutlet var titleBackground: UIView!
    
    var newMedia: Bool?
    let model = Bement_Buildings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.textLabel.font = UIFont.boldSystemFont(ofSize: 35)
        titleLabel.textLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textLabel.textAlignment = .center
        titleLabel.setColors([#colorLiteral(red: 1, green: 0, blue: 0.8563808203, alpha: 1), #colorLiteral(red: 0, green: 0.8750895858, blue: 1, alpha: 1)])
        titleLabel.setText("Identify Beta")
        titleLabel.start(shiftPoint: .left)
        titleLabel.end(shiftPoint: .right)
        titleLabel.animationDuration(3.0)
        titleLabel.maskToText = true
        
        shootButton.layer.cornerRadius = 20
        
        titleBackground.layer.cornerRadius = 15
        welcomeLabel.layer.cornerRadius = 15
        welcomeLabel.layer.masksToBounds = true
        infoLabel.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.startTimedAnimation()
    }
    
    @IBAction func useCamera(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
    }
    
    @IBAction func useCameraRoll(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            newMedia = false
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerController.InfoKey.originalImage]
                as! UIImage
            
            titleLabel.isHidden = true
            infoLabel.isHidden = true
            welcomeLabel.isHidden = true
            cameraView.isHidden = false
            cameraView.image = image
            titleBackground.isHidden = true
            
            if newMedia == true {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
            
            guard let buildingIdOutput = try? model.prediction(input: Bement_BuildingsInput(image: buffer(from: image)!)) else {
                fatalError("Unexpected runtime error.")
            }
            
            let output = buildingIdOutput.classLabelProbs
            let result = buildingIdOutput.classLabel
            
            if (output[result]!) <= 0.65 {
                //print("None of the them is a Bement Building")
                let alert = UIAlertController(title: "Sorry", message: "I cannot identify what building it is", preferredStyle: .alert)
                let button = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alert.addAction(button)
                self.present(alert, animated: true)
            } else {
                //print(result)
                let alert = UIAlertController(title: "Congrats!", message: "You found \(result)", preferredStyle: .alert)
                let button = UIAlertAction(title: "Yeah!", style: .cancel, handler: nil)
                
                alert.addAction(button)
                self.present(alert, animated: true)
            }
        }
    }
    
    func buffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard status == kCVReturnSuccess else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        
        if userInterfaceStyle == .dark {
        } else {
        }
    }
}
