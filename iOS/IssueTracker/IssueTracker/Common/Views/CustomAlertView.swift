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
    func showAlert(type: TextFieldType,
                   id: Int? = nil,
                   title: String = "",
                   description: String = "",
                   date: String = "",
                   colorLabel: String = "#123321",

                   complition: @escaping (() -> Void)) {
        let storyboard = UIStoryboard(name: "CustomAlertController", bundle: nil)
        
        let customAlertView = storyboard.instantiateViewController(
            identifier: "CustomAlertViewID",
            creator: { coder -> CustomAlertView? in
                return CustomAlertView(coder: coder,
                                       type: type,
                                       id: id,
                                       title: title,
                                       description: description,
                                       date: date,
                                       colorLabel: colorLabel,
                                       complition: complition)
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
    private var titleText: String?
    private var descriptionText: String?
    private var dateText: String?
    private var colorLabelText: String?
    private var id: Int?
    private var complition: (() -> Void)
    @IBOutlet weak var deleteButton: UIButton!
    
    required init?(coder: NSCoder) {
        complition = {}
        super.init(coder: coder)
    }

    required init?(coder: NSCoder,
                   type: TextFieldType,
                   id: Int?,
                   title: String?,
                   description: String?,
                   date: String?,
                   colorLabel: String?,
                   complition: @escaping () -> Void) {
        self.id = id
        self.titleText = title
        self.descriptionText = description
        self.dateText = date?.components(separatedBy: "T").first
        self.colorLabelText = colorLabel
        self.type = type
        self.complition = complition
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        titleTextField.text = titleText
        descriptionTextField.text = descriptionText

        if id == nil {
            deleteButton.isHidden = true
        }
        
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        switch type {
        case .color:
            dateView.isHidden = true
            colorView.isHidden = false
            colorLabel.text = colorLabelText
            colorBackgroundView.backgroundColor =  UIColor(hex: colorLabelText ?? "#123321")
        case .date:
            dateView.isHidden = false
            colorView.isHidden = true
            dateTextField.text = dateText
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
  
    private let networkService = NetworkService()
    private var addLabel: AddLabel!
    private var addMilestone: AddMilestone!
    private var endpoint: APIConfiguration!

    @IBAction func deleteButtonTouched(_ sender: Any) {

        switch type {
        case .color:
            let encodedData = AddLabel(id: id, name: nil, description: nil, color: nil).encoded()
            endpoint = LabelEndPoint.deleteLabel(encodedData)
        case .date:
            let encodedData = AddMilestone(id: id, name: nil, description: nil, dueDate: nil).encoded()
            endpoint = MilestoneEndPoint.deleteMilestone(encodedData)
        case .none:
            break
        }

        networkService.request(apiConfiguration: endpoint) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success:
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                    self.complition()
                }
            }
        }
    }

    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "YYYY-MM-dd"
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

    private func makeEndPoint(_ name: String?,
                              _ description: String?,
                              _ color: String?,
                              _ dueDate: String?) -> APIConfiguration? {
        switch type {
        case .color:
            let encodedData = AddLabel(id: id, name: name, description: description, color: color).encoded()

            if id == nil {
                return LabelEndPoint.addLabel(encodedData)
            } else {
                return LabelEndPoint.editLabel(encodedData)
            }
        case .date:
            guard let dueDate = dueDate else { return nil }

            let encodedData = AddMilestone(id: id, name: name, description: description, dueDate: dueDate).encoded()

            if id == nil {
                return MilestoneEndPoint.addMilestone(encodedData)
            } else {
                return MilestoneEndPoint.editMilestone(encodedData)
            }
        case .none:
            break
        }
        return nil
    }

    @IBAction func saveButtonTouched(_ sender: Any) {
        var flag = false

        let name = titleTextField.text
        let description = descriptionTextField.text
        let color = colorLabel.text
        let dueDate = dateTextField.text

        switch "" {
        case name:
            titleTextField.shake()
            flag = true
            fallthrough
        case description:
            descriptionTextField.shake()
            flag = true
            fallthrough
        case dueDate:
            dateTextField.shake()
            if dateTextField.isHidden {
                flag = true
            }
        default:
            break
        }

        guard !flag else { return }

        endpoint = makeEndPoint(name, description, color, dueDate)

        networkService.request(apiConfiguration: endpoint) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success:
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                    self.complition()
                }
            }
        }

    }
  
    func makeLabelNetwork(name: String, description: String, color: String, dueDate: String) {

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
      
       if textField == titleTextField {
           if dateView.isHidden {
                descriptionTextField.becomeFirstResponder()
            } else {
                dateTextField.becomeFirstResponder()
            }
        } else if textField == dateTextField {
            descriptionTextField.becomeFirstResponder()
        } else if textField == descriptionTextField {
            descriptionTextField.resignFirstResponder()
        }
        return true
    }
}

struct AddLabel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let color: String?
}

struct AddMilestone: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let dueDate: String?
}
