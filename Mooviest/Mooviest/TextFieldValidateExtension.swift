//
//  TextFieldValidateExtension.swift
//  Mooviest
//
//  Created by Antonio RG on 21/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

extension TextFieldView {
    
    func validateNumberOfCharacters(minLength: Int, maxLength: Int)->Bool {
        let msg = NSLocalizedString("validateNumberOfCharactersMsg", comment: "Message of validateNumberOfCharacters").replacingOccurrences(of: "minLength", with: "\(minLength)").replacingOccurrences(of: "maxLength", with: "\(maxLength)")
        let successful = textField.text!.characters.count >= minLength && textField.text!.characters.count <= maxLength
        self.setErrorText(message: successful ? "":msg)
        
        return successful
    }
    
    func validateEmail()->Bool {
        let msg = NSLocalizedString("validateEmailMsg", comment: "Message of validateEmail")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let successful = emailTest.evaluate(with: textField.text)
        self.setErrorText(message: successful ? "":msg)
        
        return successful
    }
    
    func validateTextEqualTo(TextFieldView t: TextFieldView)->Bool {
        let msg = NSLocalizedString("validateTextEqualToMsg", comment: "Message of validateTextEqualTo")
        let successful = self.textField.text == t.textField.text
        self.setErrorText(message: successful ? "":msg)
        
        return successful
    }
    
    func validateDate(dateFormat: String)->Bool {
        let msg = NSLocalizedString("validateDateMsg", comment: "Message of validateDate")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: self.textField.text!)
        let successful = date != nil || textField.text! == ""
        self.setErrorText(message: successful ? "":msg)
        
        return successful
    }
    
    func validateTextIndexOf(strings: [String], message: String)->Bool {
        let i = strings.index(of: textField.text!)
        let successful = i != nil || textField.text! == ""
        self.setErrorText(message: successful ? "":message)

        return successful
    }
}
