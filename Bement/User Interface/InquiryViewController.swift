//
//  InquiryViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 7/16/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import MessageUI
import IQKeyboardManagerSwift

class InquiryViewController: UIViewController, MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var pickerDataSource = ["2020-2021", "2021-2022", "2022-2023", "2023-2024", "2024-2025", "2025-2026"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row] as String
    }

    @IBOutlet var nameField: UITextField!
    @IBOutlet var parentNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var streetField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var stateField: UITextField!
    @IBOutlet var countryField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var yearApplying: UIButton!
    @IBOutlet var gradeApplying: UIButton!
    @IBOutlet var currentGrade: UIButton!
    @IBOutlet var howLearned: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if traitCollection.userInterfaceStyle == .dark {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarTintColor = .white
        } else {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarTintColor = .black
        }
        
        Tools.beautifulButton(sendButton)
        
        nameField.delegate = self
        parentNameField.delegate = self
        emailField.delegate = self
        streetField.delegate = self
        cityField.delegate = self
        stateField.delegate = self
        countryField.delegate = self
        howLearned.delegate = self
    }

    @IBAction func sendClicked(_ sender: Any) {
        if nameField.text!.replacingOccurrences(of: " ", with: "") != "" && parentNameField.text?.replacingOccurrences(of: " ", with: "") != "" && emailField.text!.replacingOccurrences(of: " ", with: "") != "" && countryField.text?.replacingOccurrences(of: " ", with: "") != "" && gradeApplying.title(for: .normal) != "Please select the grade" && yearApplying.title(for: .normal) != "Please select the year" {
            
            let message = """
                        <h1>Inquiry Submission</h1>
                        <p>My name is \(nameField.text ?? "") and my parent/guardian's name is \(parentNameField.text ?? "N/A")</p>
                        <p>My email is: \(emailField.text ?? "N/A")</p>
                        <p>Address:</p>
                        <p>\(streetField.text ?? "N/A")</p>
                        <p>\(cityField.text ?? "N/A")</p>
                        <p>\(stateField.text ?? "N/A")</p>
                        <p>\(countryField.text ?? "N/A")</p>
                        <p>I am applying for grade \(gradeApplying.title(for: .normal) ?? "N/A") in \(yearApplying.title(for: .normal) ?? "N/A"). I am currently a \(currentGrade.title(for: .normal) ?? "N/A") grader.</p>
                        <p>How I learned about Bement?</p>
                        <p>\(howLearned.text ?? "N/A")</p>
                        """
            print(message)
            sendEmail(with: message)
        } else {
            let alert = UIAlertController(title: "Error", message: "You must fill all the fields!", preferredStyle: .alert)
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func sendEmail(with input: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["admit@bement.org"])
            mail.setSubject("Inquiry Submission")
            mail.setMessageBody(input, isHTML: true)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Your device cannot send emails.", preferredStyle: .alert)
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func applyForYear(_ sender: Any) {
        let myPicker: UIPickerView = UIPickerView()
        
        pickerDataSource = ["2020-2021", "2021-2022", "2022-2023", "2023-2024", "2024-2025", "2025-2026"]
        
        myPicker.delegate = self
        myPicker.dataSource = self
        myPicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myPicker)
        let set = UIAlertAction(title: "Set", style: .default) { _ in
            self.yearApplying.setTitle(self.pickerDataSource[myPicker.selectedRow(inComponent: 0)], for: .normal)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(set)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    @IBAction func applyForGrade(_ sender: Any) {
        let myPicker: UIPickerView = UIPickerView()
        
        pickerDataSource = ["K", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        myPicker.delegate = self
        myPicker.dataSource = self
        myPicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myPicker)
        let set = UIAlertAction(title: "Set", style: .default) { _ in
            self.gradeApplying.setTitle(self.pickerDataSource[myPicker.selectedRow(inComponent: 0)], for: .normal)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(set)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    @IBAction func setCurrentGradeAttending(_ sender: Any) {
        let myPicker: UIPickerView = UIPickerView()
        
        pickerDataSource = ["PK", "K", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        myPicker.delegate = self
        myPicker.dataSource = self
        myPicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myPicker)
        let set = UIAlertAction(title: "Set", style: .default) { _ in
            self.currentGrade.setTitle(self.pickerDataSource[myPicker.selectedRow(inComponent: 0)], for: .normal)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(set)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
                
        if userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
            nameField.textColor = .white
            parentNameField.textColor = .white
            emailField.textColor = .white
            streetField.textColor = .white
            cityField.textColor = .white
            stateField.textColor = .white
            countryField.textColor = .white
            howLearned.textColor = .white
            
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarTintColor = .white
        } else {
            self.view.backgroundColor = .white
            nameField.textColor = .black
            parentNameField.textColor = .black
            emailField.textColor = .black
            streetField.textColor = .black
            cityField.textColor = .black
            stateField.textColor = .black
            countryField.textColor = .black
            howLearned.textColor = .black
            
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarTintColor = .black
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
}
