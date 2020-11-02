//
//  ForgotPasswordView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI
import Logging

struct ForgotPasswordView: View {
    
    @EnvironmentObject var kGuardian: KeyboardGuardian
    @EnvironmentObject var viewModel: LoginVM
    @State var alertSM: AlertStateModel = AlertStateModel()
    
    var body: some View {
        var tap: some Gesture {
                TapGesture(count: 1)
                .onEnded (onTapDismissKeyboard)
        }
        
        return Group {
            
            HStack(alignment:.center) {
                ActivityIndicatorView(isVisible: $alertSM.shouldAnimate, type: .growingArc(Color.primaryVariant100))
                .frame(width: 100, height: 100, alignment: .center)
                .offset(x:UIScreen.main.bounds.width/2.0 - 50)
            }
            
            ZStack {
                
                VStack() {
                                            
                    Spacer()
                    
                    Text("Enter your user name below to reset your password, then hit Submit. We'll then send you a verification code via your registered email address.")
                        .font(.h3)
                        .foregroundColor(.primeLabel)
                        .frame(maxWidth: 400)
                        .multilineTextAlignment(.center)
                        .padding()
                        .offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))

                        .alert(isPresented:$alertSM.showAlert) {
                            if(alertSM.showSuccessAlert)
                            {
                                return Alert(title: Text("Forgot Password Success"), message: Text(alertSM.alertMessage), dismissButton: .default(Text("Next"))
                                        {
                                            toLoginViewWithUserNameView()
                                            print("Next button tapped")
                                        } )
                            }
                            else
                            {
                                return Alert(title: Text("Forgot Password Error"), message: Text(alertSM.alertMessage), dismissButton: .default(Text("Dismiss")))
                            }
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
                        
                    }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))
                    .onAppear { kGuardian.addObserver(); kGuardian.textFieldOffset = 0 }
                                        
                    Spacer()
                    
                    Button(action: {submitPressed(username:viewModel.username, alertSM:&alertSM)} ) {

                        Text("SUBMIT")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 405, height: 47)
                            .background(Color(UIColor.systemTeal))
                            .cornerRadius(15.0)
                            .padding(.bottom, 10)
                    }
                    
                    Spacer()

                }.padding(.horizontal) .frame(maxWidth: .infinity)
            }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 3.0)))
            .edgesIgnoringSafeArea(.all)
            .modifier(gradientBackGround())
            .gesture(tap)
        }//Group
    }
    
    func toLoginViewWithUserNameView()
    {
        var logger = Logger(label: "ForgotPasswordView")
        #if DEBUG
            logger.logLevel = .debug
        #endif
        logger.debug("toLoginViewWithUserNameView")
        let loginState:LoginState = LoginState.forgotPasswordSignin
        Settings.setLoginState(loginState)
        //Switch to LoginView with username on SceneDelegate
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootSwiftViewToLoginWithUsername(username: viewModel.username)
    }
    
    private func onTapDismissKeyboard(tap: TapGesture.Value) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func submitPressed(username: String, alertSM: inout AlertStateModel) {

        var logger = Logger(label: "ForgotPasswordView")
        #if DEBUG
            logger.logLevel = .debug
        #endif
        logger.debug("submitPressed : username = \(username) ")
        alertSM.shouldAnimate = true
        Settings.shared.userName = username

        if !username.isEmpty {
            DispatchQueue.main.async {
                self.alertSM.shouldAnimate = false
                self.alertSM.showAlert = true
                self.alertSM.showSuccessAlert = true
                self.alertSM.alertMessage = "Confirmation code sent to your email "
            }
        }
        else
        {
            logger.debug("Username is empty.")
            DispatchQueue.main.async {
                self.alertSM.shouldAnimate = false
                self.alertSM.showAlert = true
                self.alertSM.showSuccessAlert = false
                self.alertSM.alertMessage = "Please enter a user name"
            }
        }
            
    }
        
}

struct ForgotPasswordView_Previews: PreviewProvider {

    static var previews: some View {
        let viewModel = LoginVM(username: "", navBarHidden: NavBarHidden())
        ForgotPasswordView().environmentObject(viewModel)

    }
}

