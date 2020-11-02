//
//  CustomTextFieldHeight.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct CustomTextFieldHeightKG: View {
    var placeholder: Text
    @Binding var text: String
    var tag: Int = 0
    var kGuardian: KeyboardGuardian
    var textFieldHeight: CGFloat
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .center) {
            if text.isEmpty { placeholder }
                TextField("", text: $text, onEditingChanged: {if $0 { kGuardian.showField = tag; }})
                    .textFieldStyle(DefaultTextFieldStyle())
                    .frame(height: textFieldHeight)
                    .multilineTextAlignment(TextAlignment.center)
        }
    }

}

struct CustomTextFieldHeight: View {
    var placeholder: Text
    @Binding var text: String
    var textFieldHeight: CGFloat
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .center) {
            if text.isEmpty { placeholder }
                TextField("", text: $text)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .frame(height: textFieldHeight)
                    .multilineTextAlignment(TextAlignment.center)
        }
    }

}
