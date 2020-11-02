//
//  CustomSecureTextFieldHeight.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct CustomSecureTextFieldHeight: View {
    var placeholder: Text
    @Binding var text: String
    var textFieldHeight: CGFloat
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .center) {
            if text.isEmpty { placeholder }
            SecureField("", text: $text)
            .frame(height: textFieldHeight)
            .multilineTextAlignment(TextAlignment.center)
        }
    }
}
