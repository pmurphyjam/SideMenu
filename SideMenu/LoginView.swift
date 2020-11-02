//
//  LoginView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI
import Logging

struct LoginView: View {
    
    @EnvironmentObject var kGuardian: KeyboardGuardian
    @EnvironmentObject var viewModel: LoginVM
    @State var alertSM: AlertStateModel = AlertStateModel()

    var body: some View {

        HStack(alignment:.center) {
            ActivityIndicatorView(isVisible: $alertSM.shouldAnimate, type: .growingArc(Color.primaryVariant100))
            .frame(width: 100, height: 100, alignment: .center)
            .offset(x:UIScreen.main.bounds.width/2.0 - 50)
        }
        
        NavigationView {
            
            ZStack {

                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    HStack {
                        Text("SwiftUI")
                            .font(.h1)
                            .frame(alignment:.trailing)
                            .foregroundColor(.loginLabelColor)
                            .shadow(color:Color(UIColor.systemGray), radius:5)
                    }

                    HStack {
                        
                        CustomTextFieldKG (
                            placeholder: Text("Username").foregroundColor(Color.primeLabel),text: $viewModel.username, tag:0, kGuardian: kGuardian
                        ).background(rectReader($kGuardian.rects[0]))

                        .autocapitalization(.none)
                        .padding()
                        .background(Color.textFieldFillColor)
                        .cornerRadius(5.0)
                        .frame(width:200)
                        
                        CustomSecureTextField (
                            placeholder: Text("Password").foregroundColor(Color.primeLabel),text: $viewModel.password
                        ).autocapitalization(.none)
                        .padding()
                        .background(Color.textFieldFillColor)
                        .cornerRadius(5.0)
                        .frame(width:200)
                        
                    }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))
                
                    NavigationButtons(viewModel: viewModel, alertSM: alertSM)
                    .navigationBarTitle("")
                        .navigationBarHidden(viewModel.navBarHidden.navBarIsHidden)
                    .edgesIgnoringSafeArea(.all)
                    
                    .alert(isPresented:$alertSM.showAlert) {
                        Alert(title: Text("Login Error"), message: Text(alertSM.alertMessage), dismissButton: .default(Text("Dismiss")))
                    }
                                    
                    Text(" © Company LLC. " )
                        .font(.subtitle)
                        .foregroundColor(.blackTextNotDynColor)
                        .minimumScaleFactor(0.5)
                        .frame(alignment:.center)
                    
                    Text("Build Date: " + viewModel.gitInfo)
                        .font(.subtitleLight)
                        .foregroundColor(.grayTextNotDynColor)
                        .minimumScaleFactor(0.5)
                        .frame(alignment:.center)
                
                    versionView()
                    
                    Spacer()  //Need this for iPad
                
                }.padding(.horizontal) .frame(maxWidth: .infinity)
            }.background(
                Image("background")
                    .resizable()
                    .scaledToFill()
            ).edgesIgnoringSafeArea(.all)
        }.landscapeNavigationView()
        .onAppear { kGuardian.addObserver(); kGuardian.textFieldOffset = 10;}
        .onDisappear { kGuardian.removeObserver(); }
    }
    
    private func onTapDismissKeyboard(tap: TapGesture.Value) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct NavigationButtons: View {
    
    @ObservedObject var viewModel: LoginVM
    @State var alertSM: AlertStateModel
    
    var body: some View {
        
        HStack {
            //Postion the buttons evenly throughout HStack via Spacer's
            Spacer()

            Button(action: {self.registerPressed()} ) {
                // NavigationBar logic to selectively hide
                NavigationLink(destination: RegisterView().environmentObject(viewModel).onAppear {
                    self.viewModel.navBarHidden.navBarIsHidden = false;
                }.navigationBarTitle(viewModel.registerNavTitle).onDisappear{viewModel.navBarHidden.navBarIsHidden = true; }) {

                    Text(viewModel.registerNavTitle)
                        .font(.footnote)
                        .bold()
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.buttonColor)
                        .padding(.leading, 30)
                }
            }.frame(width:150)
            .edgesIgnoringSafeArea(.all)
            
            Spacer()

            Button(action: {loginPressed(viewModel:viewModel, alertSM:&alertSM)} ) {

                Text("LOGIN")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 405, height: 47)
                    .background(Color(UIColor.systemTeal))
                    .cornerRadius(15.0)
                    .padding(.bottom, 10)
                    
            }
            
            Spacer()

            Button(action: {self.forgotPasswordPressed()} ) {
                // NavigationBar logic to selectively hide
                NavigationLink(destination: ForgotPasswordView().environmentObject(viewModel).onAppear {
                    self.viewModel.navBarHidden.navBarIsHidden = false;
                }.navigationBarTitle(viewModel.forgotPasswordNavTitle).onDisappear{viewModel.navBarHidden.navBarIsHidden = true}) {

                    Text(viewModel.forgotPasswordNavTitle)
                        .font(.footnote)
                        .bold()
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.buttonColor)
                        .padding(.trailing, 30)
                }
            }.frame(width:150)
            .edgesIgnoringSafeArea(.all)
            
            Spacer()
        }.edgesIgnoringSafeArea(.all)
    }
    
    func loginPressed(viewModel: LoginVM, alertSM: inout AlertStateModel) {
        var logger = Logger(label: "LoginView")
        #if DEBUG
               logger.logLevel = .debug
        #endif
        logger.debug("loginPressed : username = \(viewModel.username) : password = \(viewModel.password)")

        alertSM.shouldAnimate = true
        if !viewModel.username.isEmpty && !viewModel.password.isEmpty {
            let loginState:LoginState = LoginState.login
            Settings.setLoginState(loginState)
            successContinue()
            //Switch to MenuView on SceneDelegate
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootSwiftViewToMenu()
        }
        else
        {
            if viewModel.username.isEmpty && viewModel.password.isEmpty{
                logger.debug("Username and pasword is empty.")
                alertSM.shouldAnimate = false
                alertSM.showAlert = true
                alertSM.alertMessage = "Please enter a user name and password"
            } else if viewModel.username.isEmpty {
                logger.debug("Username is empty.")
                alertSM.shouldAnimate = false
                alertSM.showAlert = true
                alertSM.alertMessage = "Please enter a user name"
            } else if viewModel.password.isEmpty {
                logger.debug("Password is empty.")
                alertSM.shouldAnimate = false
                alertSM.showAlert = true
                alertSM.alertMessage = "Please enter a password"
            }
        }
    }
    
    func forgotPasswordPressed() {
        var logger = Logger(label: "LoginView")
        #if DEBUG
            logger.logLevel = .debug
        #endif
        logger.debug("forgotPasswordPressed")
    }
    
    func registerPressed() {
        var logger = Logger(label: "LoginView")
        #if DEBUG
            logger.logLevel = .debug
        #endif
        logger.debug("registerPressed")
    }
    
    internal func successContinue() {

    }
}

struct ForgotPasswordButtonView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {self.forgotPasswordPressed()} ) {
                Text("Forgot password")
                .font(.footnote)
                .foregroundColor(.blue)
                .bold()
                .padding(.trailing, 40)
            }
        }
    }
    
    func forgotPasswordPressed() {
        var logger = Logger(label: "LoginView")
        #if DEBUG
            logger.logLevel = .debug
        #endif
        logger.debug("forgotPasswordPressed")
    }
}

struct versionView: View {
    let build = Settings.getBuildVersion() + ":" + Settings.getBuildNumber()
    var body: some View {
        HStack {
            Spacer()
            Text("Version: " + build)
            .foregroundColor(.blackTextNotDynColor)
            .frame(alignment:.trailing)
            .font(.footnote)
            .padding(.bottom, 30)
            .padding(.trailing, 20)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginVM(username: "",navBarHidden: NavBarHidden())
        LoginView().environmentObject(viewModel)
    }
}
