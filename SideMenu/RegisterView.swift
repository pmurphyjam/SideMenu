//
//  RegisterView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI
import Logging

struct RegisterView: View {

    @EnvironmentObject var kGuardian: KeyboardGuardian
    @EnvironmentObject var viewModel: LoginVM
    @State var alertSM: AlertStateModel = AlertStateModel()

    let registerConfirmationNavTitle = "Register Confirmation"
    let textFieldHeight:CGFloat = 40.0
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-DD"
        return df
    }()
    
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
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("Enter your user information below to create your account, then hit Submit. We'll then send you an email with a link to verify your new account.")
                        .font(.h3)
                        .foregroundColor(.primeLabel)
                        .frame(maxWidth: 400)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                        .alert(isPresented:$alertSM.showAlert) {
                            if(alertSM.showSuccessAlert)
                            {
                                return Alert(title: Text("Register Success"), message: Text(alertSM.alertMessage), dismissButton: .default(Text("To Login"))
                                    {
                                       //Our state variable causes our navigation link to go active with showNextView
                                        toLoginViewWithUserNameView()
                                        print("To Login button tapped")
                                    })
                            }
                            else
                            {
                                return Alert(title: Text("Register Error"), message: Text(alertSM.alertMessage), dismissButton: .default(Text("Dismiss")))
                            }
                        }
                    
                    VStack {
                        
                            HStack {
                                
                                CustomTextFieldHeightKG (
                                    placeholder: Text("Username").foregroundColor(Color.primeLabel), text: $viewModel.username, tag:0, kGuardian: kGuardian, textFieldHeight: textFieldHeight
                                ).background(rectReader($kGuardian.rects[0]))
                                .autocapitalization(.none)
                                .background(Color.textFieldFillColor)
                                .cornerRadius(5.0)
                                .frame(width:200, height:textFieldHeight)
                                
                                CustomSecureTextFieldHeight (
                                    placeholder: Text("Password").foregroundColor(Color.primeLabel), text: $viewModel.password, textFieldHeight: textFieldHeight
                                )
                                .autocapitalization(.none)
                                .background(Color.textFieldFillColor)
                                .cornerRadius(5.0)
                                .frame(width:200, height:textFieldHeight)
                                
                            }
                            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))
                                        
                            HStack {
                                
                                CustomTextFieldHeightKG (
                                    placeholder: Text("First Name").foregroundColor(Color.primeLabel), text: $viewModel.firstName, tag:1, kGuardian: kGuardian, textFieldHeight: textFieldHeight
                                ).background(rectReader($kGuardian.rects[1]))
                                .autocapitalization(.words)
                                .background(Color.textFieldFillColor)
                                .cornerRadius(5.0)
                                .frame(width:200, height:textFieldHeight)
                                
                                CustomTextFieldHeight (
                                    placeholder: Text("Last Name").foregroundColor(Color.primeLabel), text: $viewModel.lastName, textFieldHeight: textFieldHeight
                                )
                                .autocapitalization(.words)
                                .background(Color.textFieldFillColor)
                                .cornerRadius(5.0)
                                .frame(width:200, height:textFieldHeight)
                                
                                CustomTextFieldHeight (
                                    placeholder: Text("Phone #").foregroundColor(Color.primeLabel), text: $viewModel.phoneNumber, textFieldHeight: textFieldHeight
                                )
                                .autocapitalization(.none)
                                .background(Color.textFieldFillColor)
                                .cornerRadius(5.0)
                                .frame(width:200, height:textFieldHeight)
                                
                            }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))

                            HStack {
                                
                                CustomTextFieldHeightKG (
                                    placeholder: Text("Email").foregroundColor(Color.primeLabel), text: $viewModel.email, tag:2, kGuardian: kGuardian, textFieldHeight: textFieldHeight
                                ).background(rectReader($kGuardian.rects[2]))
                                .autocapitalization(.none)
                                .background(Color.textFieldFillColor)
                                .cornerRadius(5.0)
                                .frame(width:200, height:textFieldHeight)
                                
                                CustomDatePicker(date: $viewModel.birthDate, titleText: "Birthday:")
                                    .frame(width:200, height:textFieldHeight)
                                    .background(Color.textFieldFillColor)
                                    .cornerRadius(5.0)
                                
                                
                                
                            }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))
                            .padding(.bottom)
                        

                    } //VStack
                    .onAppear { kGuardian.addObserver(); kGuardian.textFieldOffset = 10; }
                    
                    Button(action: {submitPressed(viewModel:viewModel, alertSM:&alertSM)} ) {
                                    
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
                        
                }
                  
                
            }.padding(.horizontal) .frame(maxWidth: .infinity)
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 3.0)))
            .modifier(gradientBackGround())
            .gesture(tap)
        }//Group
    }
    
    private func onTapDismissKeyboard(tap: TapGesture.Value) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func validateEmail(_ email:String) -> Bool
    {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        let predicate:NSPredicate = NSPredicate(format: "self matches %@",regex)
        let status = predicate.evaluate(with: email)
        return status
    }
    
    func validatePassword(_ password:String) -> Bool{
        let regex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let predicate:NSPredicate = NSPredicate(format: "self matches %@",regex)
        let status = predicate.evaluate(with: password)
        return status
    }
    
    func isPhoneNumberValid(_ phoneNumber:String) -> Bool{
        let regex = "^\\+\\d{2}\\d{3}\\d{3}\\d{4}$"
        let predicate:NSPredicate = NSPredicate(format: "self matches %@",regex)
        let status = predicate.evaluate(with: phoneNumber)
        return status
    }
    
    func validateData(viewModel: LoginVM) -> AlertStateModel
    {
        var alertSM: AlertStateModel = AlertStateModel()
        if(viewModel.username.isEmpty )
        {
            alertSM.showAlert = true
            alertSM.status = false
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = false
            alertSM.alertMessage = "Please enter a valid user name."
        }
        else if(!validatePassword(viewModel.password))
        {
            print("validateData : password = \(viewModel.password)")
            alertSM.showAlert = true
            alertSM.status = false
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = false
            alertSM.alertMessage = "Please enter a valid password. It must be 8 characters long, 1 upper and lower case letter, and one number."
        }
        else if (viewModel.firstName.isEmpty )
        {
            alertSM.showAlert = true
            alertSM.status = false
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = false
            alertSM.alertMessage = "Please enter a valid first name."
        }
        else if (viewModel.lastName.isEmpty )
        {
            alertSM.showAlert = true
            alertSM.status = false
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = false
            alertSM.alertMessage = "Please enter a valid last name."
        }
        else if(!isPhoneNumberValid(viewModel.phoneNumber) )
        {
            alertSM.showAlert = true
            alertSM.status = false
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = false
            alertSM.alertMessage = "Please enter a valid phone number of format +014081234567"
        }
        else if(!validateEmail(viewModel.email) )
        {
            alertSM.showAlert = true
            alertSM.status = false
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = false
            alertSM.alertMessage = "Please enter a valid Email address."
        }
        else if (viewModel.birthdate.isEmpty )
        {
            alertSM.showAlert = true
            alertSM.status = false
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = false
            alertSM.alertMessage = "Please enter a valid birthdate."
        }
        else
        {
            alertSM.showAlert = false
            alertSM.status = true
            alertSM.showSuccessAlert = false
            alertSM.shouldAnimate = true
            alertSM.alertMessage = ""
        }
        return alertSM
    }
    
    func toLoginViewWithUserNameView()
    {
        var logger = Logger(label: "RegistgerView")
        #if DEBUG
            logger.logLevel = .debug
        #endif
        logger.debug("toLoginViewWithUserNameView")
        let loginState:LoginState = LoginState.forgotPasswordSignin
        Settings.setLoginState(loginState)
        //Switch to LoginView with username on SceneDelegate
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootSwiftViewToLoginWithUsername(username: viewModel.username)
    }
    
    func submitPressed(viewModel: LoginVM, alertSM: inout AlertStateModel) {
        var logger = Logger(label: "RegistgerView")
        #if DEBUG
            logger.logLevel = .debug
        #endif
        logger.debug("submitPressed : username = \(viewModel.username) ")
        alertSM.shouldAnimate = true
        Settings.shared.userName = viewModel.username
        Settings.shared.firstName = viewModel.firstName + " " + viewModel.lastName
        
        if let birthDate:Date = viewModel.birthDate {
            viewModel.birthdate = dateFormatter.string(from: birthDate)
            logger.debug("submitPressed : birthdate = \(viewModel.birthdate) ")
        }
        
        alertSM = validateData(viewModel:viewModel)
        
        if (alertSM.status) {
            DispatchQueue.main.async {
                logger.info("Success : User Signed up and Confirmed successfully.")
                self.alertSM.shouldAnimate = false
                self.alertSM.showAlert = true
                self.alertSM.showSuccessAlert = true
                self.alertSM.alertMessage = "Your Registration completed successfully."
            }
        }
    }
    
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginVM(username: "", navBarHidden: NavBarHidden())
        RegisterView().environmentObject(viewModel)
    }
}
