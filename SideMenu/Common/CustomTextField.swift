//
//  CustomTextField.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct CustomTextFieldKG: View {
    var placeholder: Text
    @Binding var text: String
    //@Published var text: String

    var tag: Int = 0
    var kGuardian: KeyboardGuardian
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .center) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: {if $0 { kGuardian.showField = tag; }})
            .multilineTextAlignment(TextAlignment.center)
        }
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .center) {
            if text.isEmpty { placeholder }
            TextField("", text: $text)
            .multilineTextAlignment(TextAlignment.center)
        }
    }
}
