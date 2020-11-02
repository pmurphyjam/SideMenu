//
//  Font+Ext.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import UIKit
import SwiftUI

extension Font {
    //App only uses these fonts so global changes can be made
    static let h1 = Font.largeTitle
    static let h2 = Font.headline
    static let h3 = Font.footnote
    static let h4 = Font.footnote
    static let h5 = Font.footnote
    static let body = Font.body
    static let bodyBold = Font.body.bold()
    static let bodyBold12 = Font.system(size: 12).bold()
    static let bodyBold16 = Font.system(size: 16).bold()
    static let bodyLight = Font.body.weight(.light)
    
    static let caption = Font.caption
    static let captionBold = Font.caption.bold()
    
    static let title = Font.title
    static let titleLight = Font.title.weight(.light)
    static let titleBold = Font.title.bold()

    static let button = Font.body
    static let buttonBold = Font.body.bold()
    static let button12 = Font.system(size: 12)
    static let button12Bold = Font.system(size: 12).bold()

    static let smallLabel9 = Font.system(size: 9)
    static let menuLabel12 = Font.system(size: 12)
    static let menuLabel10 = Font.system(size: 10)

    static let subtitle = Font.footnote
    static let subtitleLight = Font.footnote.weight(.light)
    static let subtitleNotDyn = Font(UIFont.init(name: "Helvetica", size: 13.0)!)
    static let subtitleLightNotDyn = Font(UIFont.init(name: "Helvetica", size: 12.0)!)
    static let subtitleApercuPro10 = Font(UIFont.init(name: "ApercuPro", size: 10.0)!)
    static let subtitleApercuPro20 = Font(UIFont.init(name: "ApercuPro", size: 20.0)!)


}
