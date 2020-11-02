//
//  AlertStateModel.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct AlertStateModel {
    //Assign as @State var alertSM in each View
    //Needs to be local to each view
    var shouldAnimate: Bool = false
    var showAlert: Bool = false
    var showSuccessAlert: Bool = false
    var alertMessage: String = ""
    var showNextView: Bool = false
    var status: Bool = false
}


