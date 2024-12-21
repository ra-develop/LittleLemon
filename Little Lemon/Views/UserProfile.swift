//
//  UserProfile.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    @State var firstName: String =             (UserDefaults.standard.string(forKey: kFirstName) ?? "")
    @State var lastName: String =             (UserDefaults.standard.string(forKey: kLastName) ?? "")
    @State var email: String =             (UserDefaults.standard.string(forKey: kEmail) ?? "")

    
    
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

/*
 
 Step 5: Add a button to logout
 Use Button and the steps below to create logout logic:

 Below the three text fields, add a Button element and initialize it with the text "Logout"

 Add a trailing empty closure that will perform the logout action.

 Above the body variable, add the following code @Environment(\.presentationMode) var presentation. This will automatically reference the presentation environment in SwiftUI which will allow you to reach the navigation logic.

 Open the Onboarding file, and add another constant at the top of the file near the other 3 registration constants to store the login status, for example let kIsLoggedIn = "kIsLoggedIn"

 Below, inside the register button closure, inside the if statement add another call to the UserDefaults and set true for the constant key defined in the previous step. This will store a flag that user is already logged in and should not see the Onboarding screen again the next time app launches.

 At the end of the VStack, the first view inside the NavigationView call an onAppear method with a trailing closure. Inside the closure, add an if check, and access the standard property of the UserDefaults, and call a bool method with a logged in key that you defined at the top of the file in the previous step. This will check if the key is set to true.

 Inside the if block, if user is logged in already - set the isLoggedIn local variable to true.

 Open the UserProfile file again, and inside the logout button trailing closure first access the standard property of the UserDefaults and set false value using the login constant as a key that you defined at the top of the Onboarding file. Then on the following line add the following code self.presentation.wrappedValue.dismiss(). When executed, it will automatically tell the NavigationView to go back to the previous screen which is Onboarding simulating logout.

 To make all the items start from the top instead of the center of the screen - add a Spacer element right after the logout button and initialize it.

 You can now try to run the app, register and when you reach the home screen start the app again. It should skip the registration and take you straight to the home screen. Then you can go to the profile screen and press a logout button. Next time you will start app again, it should present you with an onboarding screen instead of the home.


 */
