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
        let successful = textField.text!.characters.count >= minLength && textField.text!.characters.count <= maxLength
        self.setErrorText(message: successful ? "":"Enter between than \(minLength) and \(maxLength) characters")
        
        return successful
    }
    
    func validateEmail()->Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let successful = emailTest.evaluate(with: textField.text)
        self.setErrorText(message: successful ? "":"Error email format")
        
        return successful
    }
    
    func validateTextEqualTo(TextFieldView t: TextFieldView)->Bool {
        let successful = self.textField.text == t.textField.text
        self.setErrorText(message: successful ? "":"Not equal pass and confirm pass" )
        
        return successful
    }
    
    func validateDate(dateFormat: String)->Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: self.textField.text!)
        let successful = date != nil || textField.text! == ""
        self.setErrorText(message: successful ? "":"Date format incorrect")
        
        return successful
    }
    
    func validateTextIndexOf(strings: [String], message: String)->Bool {
        let i = strings.index(of: textField.text!)
        let successful = i != nil || textField.text! == ""
        self.setErrorText(message: successful ? "":message)

        return successful
    }
}
