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
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .font(Font.custom("MarkaziText", size: 32))
//                        .typographyStyle(.headline)
                    Text("Chicago")
                    Text("Little Lemon is a charming neighborhood bistro thatserves simple food and  classic cocktails in a lively but casual environment. The restaurant features a locally-sourced menu with daily specials.")
                }
                Image("Hero image")                    .resizable()
                    .frame(width: 140, height: 170)
                    .scaledToFit()
            }.padding(.horizontal, 20)
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
