//
//  CustomAlertView.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/11.
//

import UIKit

enum TextFieldType {
    case color
    case date
}

extension UIViewController {
    func showAlert(type: TextFieldType) {
        let storyboard = UIStoryboard(name: "CustomAlertController", bundle: nil)
        
        let customAlertView = storyboard.instantiateViewController(
            identifier: "CustomAlertViewID",
            creator: { coder -> CustomAlertView? in
                return CustomAlertView(coder: coder, type: type)
            })
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(customAlertView, forKey: "contentViewController")
        
        self.present(alertController, animated: true)
    }
}

class CustomAlertView: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorBackgroundView: UIView!
    
    private var type: TextFieldType?
    
    required init?(coder: NSCoder) {
        self.type = nil
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder, type: TextFieldType) {
        self.type = type
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        switch type {
        case .color:
            dateView.isHidden = true
            colorView.isHidden = false
        case .date:
            dateView.isHidden = false
            colorView.isHidden = true
            createDatePicker()
        case .none:
            return
        }
    }
    
    private let datePicker = UIDatePicker()
    
    func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = .white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolBar
        dateTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.locale = .init(identifier: "ko_KR")
        datePicker.backgroundColor = .white
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    // MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc func cancelPressed() {
        dateTextField.resignFirstResponder()
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = .init(identifier: "ko-KR")
        
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTouched(_ sender: Any) {
        
    }
    
    @IBAction func resetButtonTouched(_ sender: Any) {
        titleTextField.text = ""
        dateTextField.text = ""
        descriptionTextField.text = ""
    }
}

// MARK: UITextFieldDelegate

extension CustomAlertView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case titleTextField:
            if type == .color { descriptionTextField.becomeFirstResponder() }
            if type == .date { dateTextField.becomeFirstResponder() }
        case dateTextField:
            descriptionTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}
