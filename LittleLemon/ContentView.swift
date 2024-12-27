//
//  ContentView.swift
//  Little Lemon
//
//  Created by R.A. on 18/12/24.
//

import SwiftUI

enum NavigationDestinations: String, CaseIterable, Hashable {
    case Onboarding
    case Home
    case UserProfile
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Onboarding()
        }
    }
}

#Preview {
    ContentView()
}
