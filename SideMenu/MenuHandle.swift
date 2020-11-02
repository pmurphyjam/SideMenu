//
//  MenuHandle.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct MenuHandle : View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: handleThickness, height: 150)
            .foregroundColor(Color(UIColor.systemGray2))
            .padding(3)
    }
}
