//
//  Home.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView{
            Text("This is the Menu View")
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
