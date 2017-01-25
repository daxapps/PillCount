//
//  PillCountViewController.swift
//  PillCount
//
//  Created by Jason Crawford on 1/25/17.
//  Copyright © 2017 Jason Crawford. All rights reserved.
//

import UIKit

class PillCountViewController: UIViewController {

    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var amountPrescibedTextField: UITextField!
    @IBOutlet weak var amountPatientHasTextField: UITextField!
    @IBOutlet weak var daysUntilNextAppointmentLabel: UILabel!
    @IBOutlet weak var amountPatientShouldHaveLabel: UILabel!

    let datePicker = UIDatePicker()
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        timer = Timer.scheduledTimer(timeInterval: 3600, target:self, selector: #selector(PillCountViewController.updateDaysCounterLabel), userInfo: nil, repeats: true)
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
    }
    
    
    func updateDaysCounterLabel() {
        let timeLeft = datePicker.date.timeIntervalSinceNow
        daysUntilNextAppointmentLabel.text = timeLeft.time
    }

}

extension TimeInterval {
    var time:String {
        return String(format:"%02d", Int((self/86400)))
    }
}
