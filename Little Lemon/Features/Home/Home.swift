//
//  Home.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

struct Home: View {
    let persistenceController = PersistenceController.shared
    @State var presentUserProfile = false
    @State var presentDetail = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Little Lemon App")
                Text("Chicago")
                Text(
                    """
                    1. Short description of the whole application
                    2. Short description of the whole application
                    3. Short description of the whole application
                    4. Short description of the whole application
                    5. Short description of the whole application
                    """)
            }
            Menu()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )

                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("Logo")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            self.presentUserProfile.toggle()
                        } label: {
                            Image("profile-image-placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                        }
                    }
                }

        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(
            isPresented: $presentUserProfile,
            destination: {
                UserProfile()
            }
        )
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    Home()
}

/*




 */
