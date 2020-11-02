//
//  SettingsView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var menuState : MenuState
    @ObservedObject var settings = Settings()

    var body: some View {
    ZStack {
        
        VStack(alignment: .leading) {
            
            Button(action: {self.menuPressed()}) {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.menuImageColor)
            }
            .frame(width: 50.0, height: 50.0)
            .offset(x:50, y:15)

            Spacer()
            Text("Settings View")
                .font(
                    .largeTitle)
                .foregroundColor(
                    .white)
                .frame(maxWidth: .infinity)
            Spacer()
        }.padding(.horizontal) .frame(maxWidth: .infinity)
    }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 3.0)))
     .modifier(gradientBackGround())

    }
    
    func menuPressed() {
        DispatchQueue.main.async {
            self.menuState.setMenuPosition(position:MenuPosition.right)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(menuState: MenuState())
    }
}
