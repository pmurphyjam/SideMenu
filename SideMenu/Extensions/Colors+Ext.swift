//
//  Colors+Ext.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import UIKit
import SwiftUI

extension Color {
    //App only uses these colors so global changes can be made
    //Try to use System Colors which work with DarkMode so App is dynmaic
    //Use symantic color names like Material Components
    public static var primary100: Color {
        get {
            Color(UIColor.systemTeal).opacity(1.0)
        }
    }
    
    public static var primaryVariant100: Color {
        get {
            Color(UIColor.systemIndigo).opacity(1.0)
        }
    }
    
    public static var secondary100: Color {
        get {
            Color(UIColor.systemBlue).opacity(1.0)
        }
    }
    
    public static var error100: Color {
        get {
            Color(UIColor.systemPink).opacity(1.0)
        }
    }
    
    public static var surface100: Color {
        get {
            Color(UIColor.systemGray3).opacity(1.0)
        }
    }
    
    public static var background100: Color {
        get {
            Color(UIColor.systemGroupedBackground).opacity(1.0)
        }
    }
    
    public static var primeLabel: Color {
        get {
            Color(UIColor.label).opacity(1.0)
        }
    }
    
    public static var secondLabel: Color {
       get {
           Color(UIColor.secondaryLabel).opacity(1.0)
       }
    }
    
    public static var thirdLabel: Color {
       get {
           Color(UIColor.tertiaryLabel).opacity(1.0)
       }
    }
    
    public static var forthLabel: Color {
       get {
           Color(UIColor.quaternaryLabel).opacity(1.0)
       }
    }
    
    public static var placeHolderLabel: Color {
       get {
           Color(UIColor.placeholderText).opacity(1.0)
       }
    }
    
    public static var menuLabel: Color {
       get {
           Color(UIColor.label).opacity(1.0)
       }
    }
    
    public static var menuImageColor: Color {
       get {
           Color(UIColor.label).opacity(1.0)
       }
    }
    
    public static var menuAccountLabel: Color {
       get {
           Color(UIColor.systemOrange).opacity(1.0)
       }
    }
    
    public static var menuAccountSecondaryLabel: Color {
       get {
           Color(UIColor.secondaryLabel).opacity(1.0)
       }
    }
    
    public static var menuAccountImageBorder: Color {
       get {
           Color(UIColor.secondaryLabel).opacity(1.0)
       }
    }
    
    public static var menuIconColor: Color {
       get {
           Color(UIColor.systemBlue).opacity(1.0)
       }
    }
    
    public static var menuIconRegColor: Color {
       get {
           Color(UIColor.systemTeal).opacity(1.0)
       }
    }
    
    public static var textFieldFillColor: Color {
       get {
           Color(UIColor.tertiarySystemFill).opacity(1.0)
       }
    }
    
    public static var labelGrayDarkColor: Color {
       get {
           Color(UIColor.opaqueSeparator).opacity(1.0)
       }
    }
    
    public static var labelGrayColor: Color {
       get {
           Color(UIColor.secondaryLabel).opacity(1.0)
       }
    }
    
    public static var labelLightGrayColor: Color {
       get {
           Color(UIColor.systemGray2).opacity(1.0)
       }
    }
    
    public static var cellLightGrayColor: Color {
       get {
           Color(UIColor.systemGray2).opacity(0.2)
       }
    }
    
    public static var cellLightWhiteColor: Color {
       get {
           Color(UIColor.white).opacity(0.2)
       }
    }
    
    public static var labelWhiteColor: Color {
       get {
           Color(UIColor.systemGray6).opacity(1.0)
       }
    }
    
    
    public static var lightRedColor: Color {
       get {
           Color(UIColor.systemRed).opacity(0.7)
       }
    }
    
    public static var lightGreenColor: Color {
       get {
           Color(UIColor.systemGreen).opacity(0.7)
       }
    }
    
    public static var lightGrayColor: Color {
       get {
           Color(UIColor.systemGray).opacity(0.7)
       }
    }
    
    public static var lightGrayColor30: Color {
       get {
           Color(UIColor.systemGray2).opacity(0.30)
       }
    }

    public static var sideViewsGrayBackgroundColor: Color {
       get {
            Color(UIColor.systemGray2).opacity(1.0)
       }
    }
    
    public static var loginLabelColor: Color {
       get {
            Color(hex: "#FAE339", a: 1.0)!
       }
    }
    
    public static var grayTextNotDynColor: Color {
        get {
            Color(UIColor.gray).opacity(1.0)
        }
    }
    
    public static var blackTextNotDynColor: Color {
        get {
            Color(UIColor.black).opacity(1.0)
        }
    }
    
    public static var buttonColor: Color {
        get {
            Color(UIColor.systemTeal).opacity(1.0)
        }
    }
    
    public static var menuButtonColor: Color {
        get {
            Color(UIColor.systemGray).opacity(1.0)
        }
    }
    
    public init?(hex: String, a:Double = 1.0)  {
        let r, g, b: Double

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = Double((hexNumber & 0xff0000) >> 16) / 255
                    g = Double((hexNumber & 0x00ff00) >> 8) / 255
                    b = Double(hexNumber & 0x0000ff) / 255
                    self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
                    return
                }
            }
        }
        return nil
    }
 
}
