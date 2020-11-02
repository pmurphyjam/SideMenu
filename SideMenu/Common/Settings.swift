//
//  Settings.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI
import Combine

final class Settings: ObservableObject {

    static let shared = Settings()
    static let prefs = UserDefaults.standard

    let objectWillChange = PassthroughSubject<Void, Never>()

    @UserDefault("ShowOnStart", defaultValue: true)
    var showOnStart: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    class func getBuildDate() -> String
    {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary["BuildDate"] as! String
        return build
    }
    
    class func getGitCommit() -> String
    {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary["GitCommit"] as! String
        return build
    }
    
    class func getBuildNumber() -> String
    {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary["CFBundleVersion"] as! String
        return build
    }
    
    class func getBuildVersion() -> String
    {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary["CFBundleShortVersionString"] as! String
        return build
    }
    
    @UserDefault("UserName", defaultValue:"jsmith")
    var userName:String
    {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("FirstName", defaultValue:"John Smith")
    var firstName:String
    {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("UserPassword", defaultValue:"")
    var userPassword:String
    {
        willSet {
            objectWillChange.send()
        }
    }
    
    class func setLoginState(_ status:LoginState)
    {
        prefs.set(status.rawValue, forKey:"LoginState")
    }
    
    class func getLoginState() -> LoginState
    {
        let status:Int = prefs.integer(forKey:"LoginState")
        let loginState:LoginState = LoginState(rawValue:status)!
        return loginState
    }

    
}
