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
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .typographyStyle(.headline)
                        .foregroundStyle(.yellow)
                    Text("Chicago")
                        .typographyStyle(.subheadline)
                        .foregroundStyle(.white)
                    Text("Little Lemon is a charming neighborhood bistro thatserves simple food and  classic cocktails in a lively but casual environment. The restaurant features a locally-sourced menu with daily specials.")
                        .typographyStyle(.title3)
                        .foregroundStyle(.white)

                }
                Image("Hero image")                    .resizable()
                    .frame(width: 140, height: 170)
                    .scaledToFill()
                    .cornerRadius(20)
                    .padding(.top, 10)
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(.primaryColors1, ignoresSafeAreaEdges: .horizontal)
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
