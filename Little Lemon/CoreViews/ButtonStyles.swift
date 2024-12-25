//
//  ButtonStyles.swift
//  Little Lemon
//
//  Created by R.A. on 24/12/24.
//

import SwiftUI

struct ControlButton: ButtonStyle {
    private var foreGroundColor = Color(.highlightColors2)
    private var backGoundColor = Color(.primaryColors2)
    private var borderStrokeColor = Color(.secondaryColors1)
    private var isDisabled: Bool
    init(isActive: Bool? = true) {
        if isActive! {
            self.foreGroundColor = Color(.highlightColors2)
            self.backGoundColor = Color(.primaryColors2)
            self.borderStrokeColor = Color(.secondaryColors1)
        } else {
            self.foreGroundColor = Color(.gray)
            self.backGoundColor = Color(.clear)
            self.borderStrokeColor = Color(.gray)
        }
        isDisabled = !isActive!
    }
    func makeBody(configuration: Configuration) -> some View {
        //        if isActive {
        configuration.label
            .frame(width: 142, height: 30, alignment: .center)
            .padding()
            .foregroundStyle(foreGroundColor)
            .font(.title2)
            .background(backGoundColor)
            .cornerRadius(15)/// make the background rounded
            .overlay(
                /// apply a rounded border
                RoundedRectangle(cornerRadius: 15)
                    .stroke(borderStrokeColor, lineWidth: 2)
            )
            .disabled(isDisabled)
        //        } else {
        //            configuration.label
        //                .frame(width: 182, height: 30, alignment: .center)
        //                .padding()
        //                .foregroundStyle(.gray)
        //                .font(.title2)
        //                .cornerRadius(15) /// make the background rounded
        //                .overlay( /// apply a rounded border
        //                    RoundedRectangle(cornerRadius: 15)
        //                        .stroke(Color(.gray), lineWidth: 2)
        //                )
        //        }

    }
}

struct ChangeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 142, height: 30, alignment: .center)
            .padding()
            .foregroundStyle(.highlightColors1)
            .font(.title2)
            .background(Color(.primaryColors1))
            .cornerRadius(15)/// make the background rounded
            .overlay(
                /// apply a rounded border
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(.primaryColors1), lineWidth: 5)
            )
    }
}

#Preview {

    Button("ControlActive") {
        print("Is pressed ControlActive")
    }
    .buttonStyle(ControlButton(isActive: true))

    Button("ControlDisactive") {
        print("Is pressed ControlDisactive")
    }
    .buttonStyle(ControlButton(isActive: false))

    Button("ControlDefaultActive") {
        print("Is pressed ControlDefaultActive")
    }
    .buttonStyle(ControlButton())

    Button("Change") {
        print("Is pressed Change")
    }
    .buttonStyle(ChangeButton())
}
