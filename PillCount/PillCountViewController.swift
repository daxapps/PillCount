//
//  PillCountViewController.swift
//  PillCount
//
//  Created by Jason Crawford on 1/25/17.
//  Copyright © 2017 Jason Crawford. All rights reserved.
//

import UIKit
import Foundation

class PillCountViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var whenNextApptLabel: UILabel!
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var howManyEachDayLabel: UILabel!
    @IBOutlet weak var amountPrescibedTextField: UITextField!
    @IBOutlet weak var amountPatientHasLabel: UILabel!
    @IBOutlet weak var amountPatientHasTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var daysUntilApptTitleLabel: UILabel!
    @IBOutlet weak var daysUntilNextAppointmentLabel: UILabel!
    @IBOutlet weak var amountPatientShouldHaveLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!

    let datePicker = UIDatePicker()
    var timer = Timer()
    var amountPatientShouldHave = Double()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.amountPatientHasTextField.delegate = self
        createDatePicker()
        
        timer = Timer.scheduledTimer(timeInterval: 60, target:self, selector: #selector(PillCountViewController.updateDaysCounterLabel), userInfo: nil, repeats: true)
        
        daysUntilApptTitleLabel.isHidden = true
        daysUntilNextAppointmentLabel.isHidden = true
        amountPatientShouldHaveLabel.isHidden = true
        editButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }

    func createDatePicker() {
        
        // Format for picker
        datePicker.datePickerMode = .date
        
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTextField.inputAccessoryView = toolbar
        
        // Assigning date picker to text field
        datePickerTextField.inputView = datePicker
    }
    
    func donePressed() {
        
        // Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        datePickerTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        updateDaysCounterLabel()        
    }
    
    @IBAction func infoEnteredButtonPressed(_ sender: Any) {
        amountPatientShouldHaveLabel.text = "You Should Have \(calculateMedShouldHave()) films/pills."
        resignTextfield()
        whenNextApptLabel.text = "Your next appointment is"
//        whenNextApptLabel.isHidden = true
//        datePickerTextField.isHidden = true
        howManyEachDayLabel.isHidden = true
        amountPrescibedTextField.isHidden = true
        amountPatientHasLabel.isHidden = true
        amountPatientHasTextField.isHidden = true
        doneButton.isHidden = true
        
        daysUntilApptTitleLabel.isHidden = false
        daysUntilNextAppointmentLabel.isHidden = false
        amountPatientShouldHaveLabel.isHidden = false
        editButton.isHidden = false
        
    }
    
    
    func updateDaysCounterLabel() {
        let timeLeft = datePicker.date.timeIntervalSinceNow
        
        if timeLeft > 0 {
            daysUntilNextAppointmentLabel.text = timeLeft.time
            print("update being called")
            //timeLeft = timeLeft - 1
        } else {
            //print("Time for your appointment")
        }
    }
    
    func calculateMedShouldHave() -> Double{
        var originalAmountOfDays = Int()
        originalAmountOfDays = Int((datePicker.date.timeIntervalSinceNow/86400)+1) - Int(daysUntilNextAppointmentLabel.text!)!
        if amountPatientHasTextField.text != nil {
            amountPatientShouldHave = Double(amountPatientHasTextField.text!)! - (Double(amountPrescibedTextField.text!)! * Double(originalAmountOfDays))
        }
        return amountPatientShouldHave
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        whenNextApptLabel.isHidden = false
        datePickerTextField.isHidden = false
        howManyEachDayLabel.isHidden = false
        amountPrescibedTextField.isHidden = false
        amountPatientHasLabel.isHidden = false
        amountPatientHasTextField.isHidden = false
        doneButton.isHidden = false
        
        daysUntilApptTitleLabel.isHidden = true
        daysUntilNextAppointmentLabel.isHidden = true
        amountPatientShouldHaveLabel.isHidden = true
        editButton.isHidden = true 
        
    }
    
    
    // Keyboard
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(PillCountViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PillCountViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        resetViewFrame()
//        if amountPrescibedTextField.isFirstResponder {
//            view.frame.origin.y = getKeyboardHeight(notification) * -1/2
//        }
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        if amountPrescibedTextField.isFirstResponder {
            resetViewFrame()
        }
    }
    
    func resetViewFrame(){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Textfield
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        let data = [Constants.MessageFields.text: textField.text! as String]
//        sendMessage(data: data)
//        textField.text = ""
        return true
    }
    
    func resignTextfield() {
        if amountPatientHasTextField.isFirstResponder {
            amountPatientHasTextField.resignFirstResponder()
        }
    }

}

extension TimeInterval {
    var time:String {
        return String(format:"%0d", Int((self/86400) + 1))
    }
}
