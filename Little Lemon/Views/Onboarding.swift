//
//  Onboarding.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

let kFirstName = "FirstNameKey"
let kLastName = "LastNameKey"
let kEmail = "EmailKey"
let kPassword = "PasswordKey"
let kIsLoggedIn = "kIsLoggedIn"
let kIsSignedIn = "kIsSignedIn"


struct Onboarding: View {
    @State var firstName: String =             (UserDefaults.standard.string(forKey: kFirstName) ?? "")
    @State var lastName: String =             (UserDefaults.standard.string(forKey: kLastName) ?? "")
    @State var email: String =             (UserDefaults.standard.string(forKey: kEmail) ?? "")
    @State var password: String = ""
    @State var passwordRepeated: String = ""
    @State var isLoggedIn: Bool = (UserDefaults.standard.bool(forKey: kIsLoggedIn))
    @State var isSignedIn: Bool = (UserDefaults.standard.bool(forKey: kIsSignedIn))
    
    var body: some View {
        NavigationView {

            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                if !isSignedIn {
                    TextField("First Name", text: $firstName, onEditingChanged: { status in
                        print(status)
                    })
                    .onSubmit({
                        print("firstName submitted")
                    })
                    .onChange(of: firstName) {
                        print(firstName)
                    }
                    
                    TextField("Last Name", text: $lastName, onEditingChanged: { status in
                        print(status)
                    }).onSubmit({
                        // Add validation of firstname
                        print("lastName submitted")
                    })
                    .onChange(of: lastName) {
                        // Add validation of last name
                        print(lastName)
                    }
                }
                
                TextField("Email", text: $email, onEditingChanged: { status in
                    print(status)
                }).onSubmit({
                    // Add validation of email
                    print("email submitted")
                })
                .onChange(of: email) {
                    print(email)
                }
                
                TextField("Password", text: $password, onEditingChanged: { status in
                    print(status)
                }).onSubmit({
                    // Add validation of password
                    print("Password submitted")
                })
                .onChange(of: password) {
                    print(password)
                }
                
                if !isSignedIn {
                    TextField("Repeat Password", text: $passwordRepeated, onEditingChanged: { status in
                        print(status)
                    }).onSubmit({
                        // Add validation of repeated password
                        print("Repeated Password submitted")
                    })
                    .onChange(of: passwordRepeated) {
                        print(passwordRepeated)
                    }
                }
                
                Button(action: signIn) {
                    Text(!isSignedIn ? "Register" : "Login")
                }
                .disabled(false)
            }
            .padding()
        }
        .onAppear() {
            if isSignedIn {
                passwordRepeated =      (UserDefaults.standard.string(forKey: kPassword) ?? "")
            }
        }
    }
    
    func signIn () {
        if Validation().name(name: firstName) && Validation().name(name: lastName) &&
            Validation().password(password: password, passwordRepeated: passwordRepeated) &&
            Validation().email(email: email) {
            isLoggedIn = true
            isSignedIn = true
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(password, forKey: kPassword)
            UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
            UserDefaults.standard.set(isSignedIn, forKey: kIsSignedIn)
            password = ""


        }
    }
}

#Preview {
    Onboarding()
}
