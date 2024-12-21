//
//  GlovalSettings.swift
//  Little Lemon Dinner Menu
//
//  Created by R.A. on 29/11/24.
//

import Foundation

class GlobalSettings: ObservableObject {
    static let shared = GlobalSettings()

    @Published var itemViewSize: CGSize = CGSize(width: 120, height: 100)
}
