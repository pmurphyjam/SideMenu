//
//  CustomDatePicker.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct CustomDatePicker: View {
    var titleText: String

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    var birthDate: Binding<Date>

    var body: some View {
        VStack {
            DatePicker(selection: birthDate, in: ...Date(), displayedComponents: .date) {
                Text(titleText)//.font(Font.system(size: 14, design: .default))

            }
        }
        .font(Font.system(size: 14, design: .default))

    }
    
    public init(date: Binding<Date>, titleText:String) {
        self.birthDate = date
        self.titleText = titleText
    }

}
