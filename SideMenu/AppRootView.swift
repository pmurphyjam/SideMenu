//
//  AppRootView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct AppRootView: View {
    var body: some View {
        Group {
            if(Settings.getLoginState() == LoginState.login)
            {
                MenuView(menuState: MenuState())
            }
            else if(Settings.getLoginState() == LoginState.forgotPasswordSignin)
            {
                let username = Settings.shared.userName
                let viewModel = LoginVM(username:username, navBarHidden: NavBarHidden())
                LoginView().environmentObject(viewModel)
            }
            else
            {
                let viewModel = LoginVM(username:"",navBarHidden: NavBarHidden())
                LoginView().environmentObject(viewModel)
            }
        }
    }
}
