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

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {

            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
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
                
                TextField("Email", text: $email, onEditingChanged: { status in
                    print(status)
                }).onSubmit({
                    // Add validation of email
                    print("email submitted")
                })
                .onChange(of: email) {
                    print(email)
                }
                
                Button(action: signIn) {
                    Text("Register")
                }
            }
            .padding()
        }
    }
    
    func signIn () {
        if Validation().name(name: firstName) && Validation().name(name: lastName) && Validation().email(email: email) {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            isLoggedIn = true
        }
    }
}

#Preview {
    Onboarding()
}
