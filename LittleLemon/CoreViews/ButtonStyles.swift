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
                    .stroke(Color(.primaryColors1), lineWidth: 2)
            )
    }
}

struct CategoryButton: ButtonStyle {
    private var foreGroundColor = Color(.highlightColors2)
    private var backGoundColor = Color(.highlightColors1)
    private var borderStrokeColor = Color(.highlightColors1)
    init(isActive: Bool? = false) {
        if isActive! {
            self.foreGroundColor = Color(.highlightColors2)
            self.backGoundColor = Color(.highlightColors1)
            self.borderStrokeColor = Color(.highlightColors1)
        } else {
            self.foreGroundColor = Color(.gray)
            self.backGoundColor = Color(.clear)
            self.borderStrokeColor = Color(.gray)
        }
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 10, alignment: .center)
            .padding()
            .foregroundStyle(foreGroundColor)
            .font(.body)
            .background(Color(backGoundColor))
            .cornerRadius(10)/// make the background rounded
            .overlay(
                /// apply a rounded border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(borderStrokeColor), lineWidth: 2)
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

    Button("Category") {
        print("Is pressed Change")
    }
    .buttonStyle(CategoryButton())

    Button("Category") {
        print("Is pressed Change")
    }
    .buttonStyle(CategoryButton(isActive: true))
}
