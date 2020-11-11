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
        switch type {
        case .color:
            dateView.isHidden = true
            colorView.isHidden = false
            colorBackgroundView.backgroundColor =  UIColor(hex: colorLabel.text ?? "#ffffff")
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

    @IBAction func randomColorButtonTouched(_ sender: Any) {
        let randomColor = UIColor().random()
        colorBackgroundView.backgroundColor = UIColor().random()
        colorLabel.text = randomColor.hexString
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func saveButtonTouched(_ sender: Any) {
        let networkService = NetworkService()
        let addLabel: AddLabel
        let addMilestone: AddMilestone

        let name = titleTextField.text
        let description = descriptionTextField.text
        let color = colorLabel.text
        let dueDate = dateTextField.text

        switch type {
        case .color:
            addLabel = AddLabel(name: name, description: description, color: color)
            guard let encodedData = try? JSONEncoder().encode(addLabel) else { return }
            networkService.request(apiConfiguration: LabelEndPoint.addLabel(encodedData)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(_):
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)}
                }
            }
            return
        case .date:
            addMilestone = AddMilestone(name: name, description: description, dueDate: dueDate)
            let jsonEncode = JSONEncoder()
            jsonEncode.keyEncodingStrategy = .convertToSnakeCase
            guard let encodedData = try? jsonEncode.encode(addMilestone) else { return }

            networkService.request(apiConfiguration: MilestoneEndPoint.addMilestone(encodedData)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(_):
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)}
                }
            }
            return
        case .none:
            return
        }
    }

    @IBAction func resetButtonTouched(_ sender: Any) {
        titleTextField.text = ""
        dateTextField.text = ""
        descriptionTextField.text = ""
    }
}

extension CustomAlertView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            if dateView.isHidden {
                descriptionTextField.becomeFirstResponder()
            } else {
                dateTextField.becomeFirstResponder()
            }
        }
        return true
    }
}

struct AddLabel: Codable {
    let name: String?
    let description: String?
    let color: String?
}

struct AddMilestone: Codable {
    let name: String?
    let description: String?
    let dueDate: String?
}
