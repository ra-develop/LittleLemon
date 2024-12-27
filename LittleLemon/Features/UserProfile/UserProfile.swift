//
//  UserProfile.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation

    @ObservedObject var globalSettings = GlobalSettings.shared

    @State var firstName: String =
        (UserDefaults.standard.string(forKey: kFirstName) ?? "")
    @State var lastName: String =
        (UserDefaults.standard.string(forKey: kLastName) ?? "")
    @State var email: String =
        (UserDefaults.standard.string(forKey: kEmail) ?? "")
    @State var password: String =
        (UserDefaults.standard.string(forKey: kPassword) ?? "")
    @State var passwordRepeated: String =
        (UserDefaults.standard.string(forKey: kPassword) ?? "")
    @State var isPaswordChaged: Bool = false
    @State private var isValidate: Bool = false
    @State private var showAlert = false
    @State var isLoggedOut: Bool = false

    var body: some View {
        //        NavigationStack {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 140)
                Spacer()
            }
            Text("First name")
            TextField(
                "First Name", text: $firstName
            )
            .disableAutocorrection(true)
            .onChange(of: firstName) {
                validationCheck()

            }
            Text("Last name").padding(.top)
            TextField(
                "Last Name", text: $lastName
            )
            .disableAutocorrection(true)
            .onChange(of: lastName) {
                validationCheck()
            }
            Text("Email").padding(.top)
            TextField(
                "Email", text: $email
            )
            .disableAutocorrection(true)
            .onChange(of: email) {
                validationCheck()

            }
            Text("Password").padding(.top)
            SecureField(
                "Password", text: $password
            )
            .onChange(of: password) {
                // Add validation of password
                print("password is change")
                isPaswordChaged = true
                passwordRepeated = ""
            }
            .onSubmit {
                validationCheck()

            }

            if isPaswordChaged {
                SecureField(
                    "Repeat Password", text: $passwordRepeated
                )
                .onChange(of: passwordRepeated) {
                    // Add validation of repeated password
                    print(passwordRepeated)
                    validationCheck()
                }
            }
            HStack(alignment: .center) {
                Button(action: saveChanges) {
                    Text("Save changes")
                }
                .buttonStyle(ChangeButton())
                Spacer()
                Button(action: logOut) {
                    Text("Logout")
                }
                .buttonStyle(ControlButton())
            }.padding(.top)
            Spacer()
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Personal information")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("Logo")
            }
        }
        .alert(
            "The user data you entered contains an error.\nPlease check it and try entering it again.",
            isPresented: $showAlert
        ) {
            Button("OK", role: .cancel) {}
        }
        .navigationDestination(
            isPresented: $isLoggedOut,
            destination: {
                Onboarding()
            })
        //        }

    }

    func logOut() {
        globalSettings.isLoggedIn = false
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        UserDefaults.standard.synchronize()
        isLoggedOut.toggle()
    }

    func validationCheck() {
        isValidate =
            Validation().name(name: firstName)
            && Validation().name(name: lastName)
            && Validation().password(
                password: password, passwordRepeated: passwordRepeated)
            && Validation().email(email: email)
    }

    func saveChanges() {
        if isValidate {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(password, forKey: kPassword)
            presentation.wrappedValue.dismiss()
        } else {
            showAlert.toggle()
        }

    }
}

#Preview {
    UserProfile()
}
