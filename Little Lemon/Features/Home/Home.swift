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
        VStack {
            Text("Little Lemon App")
            Text("Chicago")
            Text("Short description of the whole application")
            Menu()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
                .navigationBarBackButtonHidden(true)
            
                .navigationDestination(isPresented: $presentUserProfile, destination: {
                    UserProfile()
                })
            Spacer()
        }


    }
}

#Preview {
    Home()
}


/*
 


 
 */
