//
//  EditProfileViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 10/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher

class EditProfileViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate , UIPickerViewDelegate, UIPickerViewDataSource, TabBarProtocol {
    
    //offset for animation
    var offset_HeaderStop:CGFloat!
    var offset_CoverStopScale:CGFloat!
    var offset_CardProfileStop:CGFloat!
    var offset_BackdropFadeOff:CGFloat!
    let USERNAME_MAX_LENGTH = 30
    let USERNAME_MIN_LENGTH = 5
    let PASS_MAX_LENGTH = 30
    let PASS_MIN_LENGTH = 5
    
    var activeField:UITextField?
    var move = CGFloat(0)
    var user:User?
    var picker:UIImagePickerController!
    var height:CGFloat!
    var v: EditProfileView!
    let genderPicker = UIPickerView()
    var genders: [String] = []
    let countryPicker = UIPickerView()
    var countries: [String] = []
    let datePicker = UIDatePicker()
    var dateFormat:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        height = self.navigationController?.navigationBar.frame.height
        v = EditProfileView(heightNavBar: height)
        setupView()
        view.addSubview(v)
        setupConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveChange()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetTabBarAndNavigationController(viewController: self)
        loadDataView()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: { _ in })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        v.coverImageView.image = chosenImage.kf.normalized
        dismiss(animated:true, completion: { _ in })
    }
    
    func photoPicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
         picker.allowsEditing = false
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
        let buttonCancelTitle = NSLocalizedString("buttonCancelTitle", comment: "Title of button Message")
        alertController.addAction(UIAlertAction(title: buttonCancelTitle, style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        let buttonPhotosTitle = NSLocalizedString("buttonPhotosTitle", comment: "Title of button Photos")
        alertController.addAction(UIAlertAction(title: buttonPhotosTitle, style: .default, handler: { (action: UIAlertAction!) in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: { _ in })

        }))
        let buttonCameraTitle = NSLocalizedString("buttonCameraTitle", comment: "Title of button Camera")
        alertController.addAction(UIAlertAction(title: buttonCameraTitle, style: .default, handler: { (action: UIAlertAction!) in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: { _ in })

        }))
        self.present(alertController, animated: true, completion: nil)

    }
    
    func setupView() {
        navigationItem.title = NSLocalizedString("editProfileViewTitle", comment: "Title of EditProfileView")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let saveButton = UIBarButtonItem(image: UIImage(named: "save"),
                                         style: UIBarButtonItemStyle.plain ,
                                         target: self, action: #selector(self.saveProfile))
        saveButton.tintColor = mooviest_red
        navigationItem.rightBarButtonItem = saveButton
        v.photoButton.addTarget(self, action: #selector(self.photoPicker), for: .touchUpInside)
        if let avatar = user?.avatar {
            v.coverImageView.kf.setImage(with: URL(string: "\(DataModel.sharedInstance.path)\(avatar)"),placeholder: UIImage(named: "contact"))
        }
        v.clearTextButton.addTarget(self, action: #selector(self.textClear(button:)), for: .touchUpInside)
        v.seTextFieldsDelegate(Delegate: self)
        
        v.userTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        v.emailTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        v.dateTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        v.genderTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        v.countryTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        
        //date picker
        datePicker.datePickerMode = .date
        v.dateTextFieldView.textField.inputView = datePicker
        let dateToolBar = UIToolbar()
        dateToolBar.barStyle = UIBarStyle.default
        dateToolBar.isTranslucent = true
        dateToolBar.tintColor = mooviest_red
        dateToolBar.sizeToFit()
        let next = NSLocalizedString("toolBarNext", comment: "Next of ToolBar")
        let doneButton = UIBarButtonItem(title: next, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.nextDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        dateToolBar.setItems([spaceButton, doneButton], animated: false)
        dateToolBar.isUserInteractionEnabled = true
        v.dateTextFieldView.textField.inputAccessoryView = dateToolBar
        datePicker.addTarget(self, action: #selector(self.datePickerChanged), for: .valueChanged)
        
        //gender picker
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.showsSelectionIndicator = true
        
        
        let male = NSLocalizedString("genderPickerMale", comment: "Genre male")
        let female = NSLocalizedString("genderPickerFemale", comment: "Genre female")
        genders = [male,female]
        v.genderTextFieldView.textField.inputView = genderPicker
        
        let genderToolBar = UIToolbar()
        genderToolBar.barStyle = UIBarStyle.default
        genderToolBar.isTranslucent = true
        genderToolBar.tintColor =  mooviest_red
        genderToolBar.sizeToFit()
        
        let doneButton2 = UIBarButtonItem(title: next, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.nextGenderPicker))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        genderToolBar.setItems([spaceButton2, doneButton2], animated: false)
        genderToolBar.isUserInteractionEnabled = true
        v.genderTextFieldView.textField.inputAccessoryView = genderToolBar
        
        //counttry picker
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryPicker.showsSelectionIndicator = true
        
        //es_ES, en_UK
        let localeIdentifier = NSLocalizedString("countryPickerCodeLang", comment: "Code lang of countryPicker")
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: localeIdentifier).displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        v.countryTextFieldView.textField.inputView = countryPicker
        
        let countryToolBar = UIToolbar()
        countryToolBar.barStyle = UIBarStyle.default
        countryToolBar.isTranslucent = true
        countryToolBar.tintColor =  mooviest_red
        countryToolBar.sizeToFit()
        
        let exit = NSLocalizedString("toolBarExit", comment: "Exit of ToolBar")
        let doneButton3 = UIBarButtonItem(title: exit, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.introCountryPicker))
        let spaceButton3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        countryToolBar.setItems([spaceButton3, doneButton3], animated: false)
        countryToolBar.isUserInteractionEnabled = true

        v.countryTextFieldView.textField.inputAccessoryView = countryToolBar
    }
    
    func nextDatePicker(){
        v.genderTextFieldView.textField.becomeFirstResponder()
    }
    func nextGenderPicker(){
        v.countryTextFieldView.textField.becomeFirstResponder()
    }
    func introCountryPicker(){
        v.countryTextFieldView.textField.resignFirstResponder()
    }
    
    func didChangeText(textField: UITextField) {
        switch textField {
        case v.userTextFieldView.textField:
            _ = v.userTextFieldView.validateNumberOfCharacters(minLength: USERNAME_MIN_LENGTH, maxLength: USERNAME_MAX_LENGTH)
        case v.emailTextFieldView.textField:
            _ = v.emailTextFieldView.validateEmail()
        case v.dateTextFieldView.textField:
            _ = v.dateTextFieldView.validateDate(dateFormat: dateFormat)
        case v.genderTextFieldView.textField:
            let genderMsg = NSLocalizedString("genderMsg", comment: "Placeholder of genderTextFieldView")
            _ = v.genderTextFieldView.validateTextIndexOf(strings: genders, message: genderMsg)
        case v.countryTextFieldView.textField:
            let countryMsg = NSLocalizedString("countryMsg", comment: "Placeholder of countryTextFieldView")
            _ = v.countryTextFieldView.validateTextIndexOf(strings: countries, message: countryMsg)
        default: break
        }
    }
    
    func validateForm()->Bool {
        let genderMsg = NSLocalizedString("genderMsg", comment: "Placeholder of genderTextFieldView")
        let countryMsg = NSLocalizedString("countryMsg", comment: "Placeholder of countryTextFieldView")
        return v.userTextFieldView.validateNumberOfCharacters(minLength: USERNAME_MIN_LENGTH, maxLength: USERNAME_MAX_LENGTH)
            && v.emailTextFieldView.validateEmail() && v.dateTextFieldView.validateDate(dateFormat: dateFormat)
            && v.genderTextFieldView.validateTextIndexOf(strings: genders, message: genderMsg)
            && v.countryTextFieldView.validateTextIndexOf(strings: countries, message: countryMsg)
    }
    
    
    func textClear(button: UIButton) {
        if let view = button.superview!.superview as? TextFieldView {
            view.clearText()
        }
    }
    
    // keyboard
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
    }
    func keyboardWillHide(notification: NSNotification) {
     
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if let origin = self.activeField?.convert((activeField?.frame.origin)!, from: self.view) {
                let positionEnd = self.view.frame.size.height - keyboardSize.height
                if origin.y + positionEnd < 0 {
                    move = positionEnd + (origin.y)
                    v.centralView.frame.origin.y += self.move
                }
            }
        }
    }

    
    //TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        textField.rightView = v.clearTextButton
        textField.rightViewMode = UITextFieldViewMode.always
        validatePickers(textField: textField)
        if let view = textField.superview as? TextFieldView {
            view.didBeginEditing()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        validatePickers(textField: activeField!)
        v.centralView.comeBackOrigin(withDuration: 0.3, moved: move)
        move = 0
        activeField = nil
        textField.rightView = nil
        if let view = textField.superview as? TextFieldView {
            view.didEndEditing()
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            let nextTag: NSInteger = textField.tag + 1;
            if let nextResponder: UIResponder? = self.view.viewWithTag(nextTag){
                nextResponder?.becomeFirstResponder()
            }
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    func validatePickers(textField: UITextField) {
        switch textField {
        case v.dateTextFieldView.textField:
            v.dateTextFieldView.setErrorText(message: "")
            if let date = stringToDate(dateFormat: dateFormat, text: textField.text!) {
                datePicker.date = date
            }
            else {
                textField.text = getDate(sender: datePicker)
            }
        case v.genderTextFieldView.textField:
            v.genderTextFieldView.setErrorText(message: "")
            let index = genders.index(of: textField.text!)
            if index == nil {
                textField.text = genders[genderPicker.selectedRow(inComponent: 0)]
            } else {
                genderPicker.selectRow(index!, inComponent: 0, animated: false)
            }
            
        case v.countryTextFieldView.textField:
            v.countryTextFieldView.setErrorText(message: "")
            let index = countries.index(of: textField.text!)
            if index == nil {
                textField.text = countries[countryPicker.selectedRow(inComponent: 0)]
            } else {
                countryPicker.selectRow(index!, inComponent: 0, animated: false)
            }
        default: break
        }

    }
    
    func getDate(sender: UIDatePicker)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: sender.date)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        v.dateTextFieldView.textField.text = getDate(sender: sender)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case genderPicker:
            v.genderTextFieldView.textField.text = genders[row]

        default:
            v.countryTextFieldView.textField.text = countries[row]        
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch pickerView {
            case genderPicker:
                count = genders.count
            default:
                count = countries.count
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var item = ""
        switch pickerView {
        case genderPicker:
            item = genders[row]
        default:
            item = countries[row]
        }
        return item
    }

    override func viewDidLayoutSubviews() {
        let widthButton = v.photoButton.bounds.size.width
        
        v.photoButton.layer.cornerRadius = 0.5 * widthButton
        v.photoButton.clipsToBounds = true
        
        v.coverImageView.layer.cornerRadius = v.coverImageView.bounds.size.width*0.5
        v.coverImageView.clipsToBounds = true
        
        v.adjustFontSizeToFitHeight()        
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }

    func stringToDate(dateFormat:String, text: String)-> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormat
        return dateFormater.date(from: text)
    }
    
    func loadDataView() {
        v.userTextFieldView.textField.text = user?.username
        v.firstNameTextFieldView.textField.text = user?.firstname
        v.lastNameTextFieldView.textField.text = user?.lastname
        v.emailTextFieldView.textField.text = user?.email
        v.countryTextFieldView.textField.text = user?.city
        if user != nil {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            let born = dateFormater.date(from: (user?.born)!)
            
            dateFormat = NSLocalizedString("dateFormat", comment: "Date format")
            dateFormater.dateFormat = dateFormat
            if born != nil {
                v.dateTextFieldView.textField.text = dateFormater.string(from: born!)
            }
            v.genderTextFieldView.textField.text = user?.gender
            if user!.gender != "" {
                v.genderTextFieldView.textField.text = user!.gender == "MA" ? genders[0]:genders[1]
            }
        }
    }
    
    func saveChange () {
        user?.username = v.userTextFieldView.getText()
        user?.firstname = v.firstNameTextFieldView.getText()
        user?.lastname = v.lastNameTextFieldView.getText()
        user?.email = v.emailTextFieldView.getText()
        
        user?.city = v.countryTextFieldView.getText()
        user?.gender = v.genderTextFieldView.getText()
        
        let index = genders.index(of: v.genderTextFieldView.getText())
        if index != nil {
            user?.gender = index == 0 ? "MA":"FE"
        }
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormat
        let born = dateFormater.date(from: v.dateTextFieldView.getText())
        dateFormater.dateFormat = "yyyy-MM-dd"
        if born != nil {
            user?.born = dateFormater.string(from: born!)
        }
    }
    
    func saveProfile(){
        if validateForm () {
            saveChange()            
            DataModel.sharedInstance.updateUser(user: user!,avatar: v.coverImageView.image!){
                (successful, title, message) in
                if successful {
                    self.user = DataModel.sharedInstance.user
                    Message.msgPopupDelay(title: title, message: message!, delay: 1, ctrl: self){}
                } else {
                    Message.msgPopupDelay(title: title, message: message!, delay: 0, ctrl: self) {
                        DataModel.sharedInstance.errorConnetion(title:title)
                    }
                }
            }    
        }
    }
}
