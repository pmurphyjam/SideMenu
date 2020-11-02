//
//  LoginVM.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

class LoginVM: Identifiable, ObservableObject {
    //Using one ViewModel for all of the Login view flows since it requires an @EnvironmentObject
    var id = UUID()
    @ObservedObject var navBarHidden: NavBarHidden
    @Published var username: String
    @Published var password: String = ""
    @Published var verificationCode: String = ""
    @Published var password1: String = ""
    @Published var password2: String = ""
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var gender: String = ""
    @Published var birthdate: String = ""
    @Published var birthDate:Date = Date().addingTimeInterval(-3600 * 24 * 365 * 10)

    @Published var phoneNumber: String = ""
    @Published var picture: String = ""
    @Published var zoneInfo: String = ""
    
    let gitInfo = Settings.getBuildDate() + " commit: " + Settings.getGitCommit()
    let forgotPasswordNavTitle = "Forgot Password"
    let registerNavTitle = "Register"
    let registerConfirmationNavTitle = "Register Confirmation"

    public init (username:String,navBarHidden:NavBarHidden) {
        self.username = username
        self.navBarHidden = navBarHidden
    }
    
}
