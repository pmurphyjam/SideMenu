//
//  View+Ext.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct gradientBackGround: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    let colorsArray1 = [Color(UIColor.white), Color(UIColor.lightGray)]
    let colorsArray2 = [Color(UIColor.lightGray), Color(UIColor.darkGray)]

    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: colorScheme == .light ? colorsArray1 : colorsArray2), startPoint: .top, endPoint: .bottom))
            .frame(minWidth:0, maxWidth:.infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

struct gradientMenuViewsBackGround: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    let colorsArray1 = [Color(UIColor.systemTeal).opacity(0.7), Color(UIColor.systemBlue).opacity(0.5)]
    let colorsArray2 = [Color(UIColor.systemTeal).opacity(0.8), Color(UIColor.systemBlue).opacity(0.8)]

    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: colorScheme == .light ? colorsArray1 : colorsArray2), startPoint: .top, endPoint: .bottom))
            .frame(minWidth:0, maxWidth:.infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    //For setting full view landscape on iPhone and iPad
    func landscapeNavigationView() -> some View {
        return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
    }
    
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
    
    //Used to position TextFields in view so keyboard doesn't cover them
    func rectReader(_ binding: Binding<CGRect>) -> some View {
        return GeometryReader { (geometry) -> AnyView in
            let rect = geometry.frame(in: .global)
            DispatchQueue.main.async {
                binding.wrappedValue = rect
            }
            return AnyView(Rectangle().fill(Color.clear))
        }
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
            if hidden {
                if !remove {
                    self.hidden()
                }
            } else {
                self
            }
        }
    
}

