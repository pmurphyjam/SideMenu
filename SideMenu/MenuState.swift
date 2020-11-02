//
//  MenuState.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import Foundation
import UIKit

class MenuState: Identifiable,ObservableObject {

    var id = UUID()
    @Published  var menuPosition: MenuPosition = MenuPosition.right

    init() {
        self.menuPosition = MenuPosition.right
    }
    
    func setMenuPosition(position:MenuPosition)
    {
        menuPosition = position
    }
    
}
