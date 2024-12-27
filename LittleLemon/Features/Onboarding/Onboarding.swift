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
    @ObservedObject var globalSettings = GlobalSettings.shared
    
    @State var firstName: String =
        (UserDefaults.standard.string(forKey: kFirstName) ?? "")
    @State var lastName: String =
        (UserDefaults.standard.string(forKey: kLastName) ?? "")
    @State var email: String =
        (UserDefaults.standard.string(forKey: kEmail) ?? "")
    @State var password: String = ""
    @State var passwordRepeated: String = ""
//    @State var isLoggedIn: Bool =
//        (UserDefaults.standard.bool(forKey: kIsLoggedIn))
    @State var isSignedIn: Bool =
        (UserDefaults.standard.bool(forKey: kIsSignedIn))
        
    @State private var isValidate: Bool = false
    @State private var showAlert = false


    var body: some View {
//        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                //            NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                //                EmptyView()
                //            }
                HStack {
                    Spacer()
                    Image("little-lemon-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300, alignment: .center)
                    Spacer()
                }
                if !isSignedIn {
                    TextField(
                        "First Name", text: $firstName
                    )
                    .disableAutocorrection(true)
                    .onChange(of: firstName) {
                        validationCheck()
                        
                    }
                    TextField(
                        "Last Name", text: $lastName
                    )
                    .disableAutocorrection(true)
                    .onChange(of: lastName) {
                        validationCheck()
                    }
                }
                
                TextField(
                    "Email", text: $email
                )
                .disableAutocorrection(true)
                .onChange(of: email) {
                    // Add validation of email
                    print(email)
                    validationCheck()
                    
                }
                
                SecureField(
                    "Password", text: $password
                )
                .disableAutocorrection(true)
                .onChange(of: password) {
                    // Add validation of password
                    print(password)
                    validationCheck()
                }
                
                if !isSignedIn {
                    SecureField(
                        "Repeat Password", text: $passwordRepeated
                    )
                    .disableAutocorrection(true)
                    .onChange(of: passwordRepeated) {
                        // Add validation of repeated password
                        print(passwordRepeated)
                        validationCheck()
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: signIn) {
                        Text(!isSignedIn ? "Register" : "Login")
                    }
                    .buttonStyle( ControlButton(isActive: isValidate) )
                    .disabled(false)
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .navigationDestination(isPresented: $globalSettings.isLoggedIn, destination: {
                Home()
            })
            .onAppear {
                if isSignedIn {
                    passwordRepeated =
                    (UserDefaults.standard.string(forKey: kPassword) ?? "")
                }
            }
            .alert("The user data you entered contains an error.\nPlease check it and try entering it again.",
                   isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
//        }
    }

    func signIn() {
        if isValidate
        {
            globalSettings.isLoggedIn = true
            isSignedIn = true
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(password, forKey: kPassword)
            UserDefaults.standard.set(globalSettings.isLoggedIn, forKey: kIsLoggedIn)
            UserDefaults.standard.set(isSignedIn, forKey: kIsSignedIn)
            password = ""

        } else {
            showAlert.toggle()
        }
    }
    
    func validationCheck() {
        isValidate = Validation().name(name: firstName)
        && Validation().name(name: lastName)
        && Validation().password(
            password: password, passwordRepeated: passwordRepeated)
        && Validation().email(email: email)
    }
}

#Preview {
    Onboarding()
}
