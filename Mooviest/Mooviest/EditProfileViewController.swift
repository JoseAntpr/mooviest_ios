//
//  EditProfileViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 10/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher

class EditProfileViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate , UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        loadDataView()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: { _ in })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        v.coverImageView.image = chosenImage.kf_normalized()
        dismiss(animated:true, completion: { _ in })
    }
    
    func photoPicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: { _ in })
    }
    
    func setupView() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let saveButton = UIBarButtonItem(image: UIImage(named: "save"),
                                         style: UIBarButtonItemStyle.plain ,
                                         target: self, action: #selector(self.saveProfile))
        saveButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = saveButton
        v.photoButton.addTarget(self, action: #selector(self.photoPicker), for: .touchUpInside)
        if let avatar = user?.avatar {
            v.coverImageView.kf_setImage(with: URL(string: "\(DataModel.sharedInstance.path)\(avatar)"),placeholder: UIImage(named: "contact"))
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
        dateToolBar.tintColor = UIColor(netHex: mooviest_red)
        dateToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.nextDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        dateToolBar.setItems([spaceButton, doneButton], animated: false)
        dateToolBar.isUserInteractionEnabled = true
        v.dateTextFieldView.textField.inputAccessoryView = dateToolBar
        datePicker.addTarget(self, action: #selector(self.datePickerChanged), for: .valueChanged)
        
        //gender picker
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.showsSelectionIndicator = true
        genders = ["Masculino","Femenino"]
        v.genderTextFieldView.textField.inputView = genderPicker
        
        let genderToolBar = UIToolbar()
        genderToolBar.barStyle = UIBarStyle.default
        genderToolBar.isTranslucent = true
        genderToolBar.tintColor = UIColor(netHex: mooviest_red)
        genderToolBar.sizeToFit()
        let doneButton2 = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.nextGenderPicker))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        genderToolBar.setItems([spaceButton2, doneButton2], animated: false)
        genderToolBar.isUserInteractionEnabled = true
        v.genderTextFieldView.textField.inputAccessoryView = genderToolBar
        
        //counttry picker
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryPicker.showsSelectionIndicator = true
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            
            //es_ES, en_UK
            let name = NSLocale(localeIdentifier: "es_ES").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        v.countryTextFieldView.textField.inputView = countryPicker
        
        let countryToolBar = UIToolbar()
        countryToolBar.barStyle = UIBarStyle.default
        countryToolBar.isTranslucent = true
        countryToolBar.tintColor = UIColor(netHex: mooviest_red)
        countryToolBar.sizeToFit()
        let doneButton3 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.introCountryPicker))
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
            _ = v.genderTextFieldView.validateTextIndexOf(strings: genders, message: "Ivalid gender")
        case v.countryTextFieldView.textField:
            _ = v.countryTextFieldView.validateTextIndexOf(strings: countries, message: "Ivalid country")
        default: break
        }
    }
    
    func validateForm()->Bool {
        return v.userTextFieldView.validateNumberOfCharacters(minLength: USERNAME_MIN_LENGTH, maxLength: USERNAME_MAX_LENGTH)
            && v.emailTextFieldView.validateEmail() && v.dateTextFieldView.validateDate(dateFormat: dateFormat)
            && v.genderTextFieldView.validateTextIndexOf(strings: genders, message: "Ivalid gender")
            && v.countryTextFieldView.validateTextIndexOf(strings: countries, message: "Ivalid country")
    }
    
    
    func textClear(button: UIButton) {
        if let view = button.superview!.superview as? TextFieldView {
            view.clearText()
        }
    }
    
    // keyboard
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let view = sender.view
            let loc = sender.location(in: view)
            let subview = view?.hitTest(loc, with: nil)
            if subview != v.formView
                && subview != v.padingformView  {
                self.view.endEditing(true)
            }
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        print("exit keyboard")
    }
    
    func keyboardWillShow(notification: NSNotification) {
        print("enter keyboard")
//        Si queda el textfield tapado por el teclado movemos el form para que se vea
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if let origin = self.activeField?.convert((activeField?.frame.origin)!, from: self.view) {
                let positionEnd = self.view.frame.size.height - keyboardSize.height //- activeField!.frame.height
                if origin.y + positionEnd < 0 {
                    move = positionEnd + (origin.y)
                    v.formView.frame.origin.y += self.move
                }
            }
        }
    }

    
    //TextField Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        v.formView.comeBackOrigin(withDuration: 0.3, moved: move)
        move = 0
        activeField = nil
        textField.rightView = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            let nextTag: NSInteger = textField.tag + 1;
            // Try to find next responder
            if let nextResponder: UIResponder? = self.view.viewWithTag(nextTag){
                nextResponder?.becomeFirstResponder()
            }
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField   
        textField.rightView = v.clearTextButton
        textField.rightViewMode = UITextFieldViewMode.always
        switch textField {
        case v.dateTextFieldView.textField:
            if textField.text == "" {
                textField.text = getDate(sender: datePicker)
                _ = v.dateTextFieldView.validateDate(dateFormat: dateFormat)
            } else {
                datePicker.date = stringToDate(dateFormat: dateFormat, text: textField.text!)
            }
        case v.genderTextFieldView.textField:
            let index = genders.index(of: textField.text!)
            if index == nil {
               textField.text = genders[0]
            } else {
                genderPicker.selectRow(index!, inComponent: 0, animated: false)
            }
        case v.countryTextFieldView.textField:
            let index = countries.index(of: textField.text!)
            if index == nil {
                textField.text = countries[0]
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
        _ = v.dateTextFieldView.validateDate(dateFormat: dateFormat)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case genderPicker:
            v.genderTextFieldView.textField.text = genders[row]
            _ = v.genderTextFieldView.validateTextIndexOf(strings: genders, message: "Ivalid gender")
        default:
            v.countryTextFieldView.textField.text = countries[row]        
            _ = v.countryTextFieldView.validateTextIndexOf(strings: countries, message: "Ivalid country")
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

    //This method is called when the autolayout engine has finished to calculate your views' frames
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

    func stringToDate(dateFormat:String, text: String)-> Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormat
        return dateFormater.date(from: text)!
    }
    
    func loadDataView() {
        v.userTextFieldView.textField.text = user?.username
        v.firstNameTextFieldView.textField.text = user?.firstname
        v.lastNameTextFieldView.textField.text = user?.lastname
        v.emailTextFieldView.textField.text = user?.email
        v.countryTextFieldView.textField.text = user?.city
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let born = dateFormater.date(from: (user?.born)!)
        dateFormat = user?.codeLang == "es" ? "dd/MM/yyyy":"yyyy/MM/dd"
        dateFormater.dateFormat = dateFormat
        v.dateTextFieldView.textField.text = dateFormater.string(from: born!)
        
        v.genderTextFieldView.textField.text = user?.gender
        if user!.gender != "" {
            print(user!.gender)
            v.genderTextFieldView.textField.text = user!.gender == "MA" ? genders[0]:genders[1]
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
        user?.born = dateFormater.string(from: born!)
    }
    
    func saveProfile(){
        if validateForm () {
            saveChange()
            
            DataModel.sharedInstance.updateUser(user: user!,avatar: v.coverImageView.image!){
                (successful, message, user) in
                if successful {
                    self.user = user
                    Message.msgPopupDelay(title: "", message: "Update successful", delay: 1, ctrl: self){}                    
                } else {
                    Message.msgPopupDelay(title: "Error update data", message: message, delay: 0, ctrl: self) {}
                }
            }    
        }
    }
}
