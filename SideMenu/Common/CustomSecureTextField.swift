//
//  CustomSecureTextField.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct CustomSecureTextFieldKG: View {
    var placeholder: Text
    @Binding var text: String
    var tag: Int = 0
    var kGuardian: KeyboardGuardian
    var editingChanged: ()->() = {  }
    var commit: ()->() = { }
    var body: some View {
        ZStack(alignment: .center) {
            if (text.isEmpty){ placeholder}
            SecureField("", text: $text, onCommit: commit)
                .textContentType(.oneTimeCode)
            .multilineTextAlignment(TextAlignment.center)
            .onTapGesture {
                //Substitute for onEditingChanged
                kGuardian.showField = tag
            }
        }
    }
}

struct CustomSecureTextField: View {
    var placeholder: Text
    @Binding var text: String
    var commit: ()->() = { }
    var body: some View {
        ZStack(alignment: .center) {
            if text.isEmpty { placeholder }
            SecureField("", text: $text, onCommit: commit)
            .multilineTextAlignment(TextAlignment.center)
        }
    }
}
