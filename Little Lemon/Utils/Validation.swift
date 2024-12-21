//
//  Validation.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import Foundation

class Validation {
    func email(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func name(name: String) -> Bool {
        return !name.isEmpty && name.count >= 2
    }
    
    func password(password: String, passwordRepeated: String) -> Bool {
        return password == passwordRepeated && !password.isEmpty && password.count >= 5 && password.count <= 32
    }
}
