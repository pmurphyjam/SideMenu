//
//  LogoutView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct LogoutView: View {
    @ObservedObject var menuState : MenuState
    @Environment(\.colorScheme) var colorScheme

    let logoutTitle: String = "Logout"
    let cancelTitle = "Cancel"

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
            
            Text("Are you sure you want to Logout?")
                .font(
                    .h2)
                .foregroundColor(
                    .secondLabel)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            HStack(alignment: .center) {
                Spacer()

                Button(action: {self.logoutPressed()} ) {
                    
                    Text(logoutTitle)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 47)
                        .background(Color(UIColor.systemTeal))
                        .cornerRadius(15.0)
                        .minimumScaleFactor(0.5)
                        .padding(.leading, 30)
                }
                
                Spacer()

                Button(action: {self.cancelPressed()} ) {
                    
                    Text(cancelTitle)
                        .font(.button)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 47)
                        .background(Color(UIColor.systemTeal))
                        .cornerRadius(15.0)
                        .minimumScaleFactor(0.5)
                        .padding(.trailing, 30)
                }
                
                Spacer()

            }
            
            Spacer()
            
        }.padding(.horizontal) .frame(maxWidth: .infinity)
    }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 3.0)))
     .modifier(gradientBackGround())
    }
    
    func logoutPressed() {
        let loginState:LoginState = LoginState.logout
        Settings.setLoginState(loginState)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootSwiftViewToLogin()
    }
    
    func cancelPressed() {
        DispatchQueue.main.async {
            self.menuState.setMenuPosition(position:MenuPosition.right)
        }
    }
    
    func menuPressed() {
        DispatchQueue.main.async {
            self.menuState.setMenuPosition(position:MenuPosition.right)
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(menuState: MenuState())
    }
}
