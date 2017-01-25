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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
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
    }
    
    @IBAction func infoEnteredButtonPressed(_ sender: Any) {
    }

}

