//
//  UserProfile.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation

    @State var firstName: String =
        (UserDefaults.standard.string(forKey: kFirstName) ?? "")
    @State var lastName: String =
        (UserDefaults.standard.string(forKey: kLastName) ?? "")
    @State var email: String =
        (UserDefaults.standard.string(forKey: kEmail) ?? "")

    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button(action: logOut) {
                Text("Logout")
            }
            Spacer()
        }
    }

    func logOut() {
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        self.presentation.wrappedValue.dismiss()
    }
}

#Preview {
    UserProfile()
}
