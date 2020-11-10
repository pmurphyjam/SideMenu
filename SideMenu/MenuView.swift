//
//  MenuView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

//Global constants go here
let menuAccount = MenuContent(name: Settings.shared.firstName, account: Settings.shared.userName, menuName:.account, image: "person.crop.circle.fill", accountType: true, systemImage:true)
let menuHome = MenuContent(name: "Home", account:"", menuName:.home, image: "house.fill", accountType: false, systemImage:true)
let menuSettings = MenuContent(name: "Settings", account:"", menuName:.settings, image: "gear", accountType: false, systemImage:true)
let menuMap = MenuContent(name: "Map", account:"", menuName:.map, image: "map", accountType: false, systemImage:true)
let menuLogout = MenuContent(name: "Logout", account:"", menuName:.logout, image: "power", accountType: false, systemImage:true)

let menuContents = [menuAccount, menuHome, menuSettings, menuMap, menuLogout]
let menuWidth:CGFloat = min((UIScreen.main.bounds.width / 3.5), 220)
let menuOffset:CGFloat = 50
let fontScaleFactor:CGFloat = 0.2
let sideViewRoundedCorners:CGFloat = 35.0
let iPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone

func modelIdentifier() -> String {
    if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
    var sysinfo = utsname()
    uname(&sysinfo) // ignore return value
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
}

func checkForiOS14() -> Bool {
    if #available(iOS 14.0, *)
    {
        return true
    }
    else
    {
        return false
    }
}

enum MenuPosition: CGFloat {
    
    case right
    case middle
    case left   
    
    var rawValue:CGFloat {
        switch self {
        case .right : return 0.0
        case .middle : return (menuWidth - menuOffset) * -1
        case .left : return (menuWidth - menuOffset - 1) * -1
        }
    }
}

enum MenuViewName: Int {
    case account = 0
    case home
    case play
    case map
    case settings
    case logout
}

enum MenuDragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

class MenuContent: Identifiable, ObservableObject {
    var id = UUID()
    var name: String = ""
    var account: String = ""
    var menuName: MenuViewName = .home
    var image: String = ""
    var accountType:Bool = false
    var systemImage:Bool = true

    init(name: String, account: String, menuName:MenuViewName, image: String, accountType:Bool, systemImage:Bool) {
        self.name = name
        self.account = account
        self.image = image
        self.menuName = menuName
        self.accountType = accountType
        self.systemImage = systemImage
    }
}

struct MenuCell: View {
    
    @ObservedObject var menuState : MenuState

    var menuItem: MenuContent = menuContents[1]
    var body: some View {
        
        HStack {
            if menuItem.systemImage {
                Image(systemName: menuItem.image)
                    .foregroundColor(.menuIconColor)
            }
            else
            {
                Image(menuItem.image)
                    .renderingMode(.template)
                    .colorMultiply(.menuIconRegColor)
                    .foregroundColor(.menuIconRegColor)
            }
            Text(menuItem.name).foregroundColor(.menuLabel)
                .padding(.trailing,20)

        }
        .frame(width:menuWidth, alignment:iPhone ? .leading : .center )
        .padding(.trailing, 10)
        .padding(.leading, 10)
    }
}

struct AccountCell: View {
    
    @ObservedObject var menuState : MenuState
    var menuItem: MenuContent = menuContents[1]
    
    var body: some View {
        HStack(alignment:.top) {

            Image("tempUser")
            .resizable()
            .frame(width:35, height:35)
            .clipShape(RoundedRectangle(cornerRadius:5))
            .overlay(RoundedRectangle(cornerRadius:5)
            .stroke(Color.menuAccountImageBorder, lineWidth: 3))
            .aspectRatio(contentMode: .fit)
            
                VStack(alignment: .leading) {
                    Text(self.menuItem.name).foregroundColor(.menuAccountLabel)
                        .font(.menuLabel12)
                        .minimumScaleFactor(0.2)
                        .padding(.trailing,5)
                    Text(self.menuItem.account).foregroundColor(.menuAccountSecondaryLabel)
                        .font(.menuLabel10)
                        .minimumScaleFactor(0.2)
                        .padding(.trailing,5)

                }
        }
        .frame(width:menuWidth, alignment:iPhone ? .leading : .center )
        .padding(.top, 15)
        .padding(.trailing, 10)
        .padding(.leading, 10)
    }
}

protocol MenuViewProtocol {
    //Used to switch between main Menu Views, home, play, etc
    func changeMenuViewTo(menuView: MenuViewName)
}

struct MenuView: View, MenuViewProtocol {
    
    //Each respectivew View will consume the tcm Object in their own ViewModel
    //But it must be connected up here in MenuView
    @EnvironmentObject var viewModel: LoginVM

    @State var menuItemSelected: MenuContent = menuContents[1]
    @GestureState private var menuDragState = MenuDragState.inactive
    @ObservedObject var menuState = MenuState()
    var menu: [MenuContent] = menuContents

    var body: some View {
        
        let drag = DragGesture()
            .updating($menuDragState) { drag, state, transaction in
            state = .dragging(translation: drag.translation)
        }
        .onEnded(onDragEnded)
        
        //print("MenuView : DeviceType = \(modelIdentifier()) : menuOffset = \(menuOffset)")
        //print("MenuView : menuPosition = \(menuState.menuPosition.rawValue)")
        //print("MenuView : menuDragState = \(menuDragState.translation.width)")

        return Group {
            
            ZStack(alignment: .leading) {
                
                //Return our new View here
                self.selected(menu: menuItemSelected)
                
                HStack(alignment: .center) {

                    //Menu Contents
                    List(self.menu) { menuItem in
                        
                        if(menuItem.accountType)
                        {
                            AccountCell(menuState: self.menuState, menuItem: menuItem).onTapGesture {
                                self.menuItemSelected = menuItem
                            }
                        }
                        else
                        {
                            MenuCell(menuState: self.menuState, menuItem: menuItem).onTapGesture {
                                self.menuItemSelected = menuItem
                            }
                        }
                        
                        }
                        .frame(minWidth:0, maxWidth:menuWidth, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                        .edgesIgnoringSafeArea(.all)
                        .listRowBackground(Color.background100)
                        .onTapGesture{
                            //print("ListView : OnTapGesture : menuCollapse")
                            self.menuCollapse()
                        }
                    
                    MenuHandle()

                }
                .background(Color.background100)
                .mask(RoundedCornerShape(radius: 25, orientation:true))
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .offset(x: self.menuState.menuPosition.rawValue + self.menuDragState.translation.width - 50.0)
                .animation(self.menuDragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                .gesture(drag)
            }
            .frame(minWidth:0, maxWidth:.infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
        } //Group
        
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        let horizontalDirection = drag.predictedEndLocation.x - drag.location.x
        let menuEdgeLocation = self.menuState.menuPosition.rawValue + drag.translation.width
        var positionRight: MenuPosition = .right
        var positionLeft: MenuPosition = .left
        let closestPosition: MenuPosition

        if menuEdgeLocation >= MenuPosition.middle.rawValue {
            positionRight = .right
            positionLeft = .middle

        } else {
            positionRight = .middle
            positionLeft = .left
        }
        
        if (menuEdgeLocation - positionRight.rawValue) < (positionLeft.rawValue - menuEdgeLocation) {
            closestPosition = positionRight
        } else {
            closestPosition = positionLeft
        }
        
        if horizontalDirection > 0 {
            self.menuState.menuPosition = positionRight
        } else if horizontalDirection < 0 {
            self.menuState.menuPosition = positionLeft
        } else {
            self.menuState.menuPosition = closestPosition
        }
        //print("ContentView : DragEnd : menuPosition = \(self.menuState.menuPosition)")
    }
    
    func menuCollapse()
    {
        menuState.setMenuPosition(position:MenuPosition.left)
    }
    
    func selected(menu: MenuContent) -> some View {

        Group {
            
            //Have to use Group otherwise transition animations down't work
            //Connect up tcm Object to respective ViewModels
            if menu.menuName == .account
            {
                AccountView(menuState: menuState, delegate: self)
            }
            else if menu.menuName == .map
            {
                MapView(menuState: menuState)
            }
            else if menu.menuName == .settings
            {
                SettingsView(menuState: menuState)
            }
            else if menu.menuName == .logout
            {
                LogoutView(menuState: menuState)
            }
            else if menu.menuName == .home
            {
                HomeView(menuState: menuState, delegate:self)
            }
            else
            {
                HomeView(menuState: menuState, delegate:self)
            }
        }

    }
    
    // MARK: - MenuView MenuViewProtocol
    //Used to switch between main Menu Views, home, map, etc
    func changeMenuViewTo(menuView: MenuViewName) {
        print("MenuView : changeMenuViewTo : menuView = \(menuView)")
        if(menuView == .account)
        {
            self.menuItemSelected = menuContents[0]
        }
        else if(menuView == .home)
        {
            self.menuItemSelected = menuContents[1]
        }
        else if(menuView == .settings)
        {
            self.menuItemSelected = menuContents[2]
        }
        else if(menuView == .map)
        {
            self.menuItemSelected = menuContents[3]
        }
        else if(menuView == .logout)
        {
            self.menuItemSelected = menuContents[4]
        }
        
        var body: some View {
            return selected(menu: self.menuItemSelected)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(menuState: MenuState())
    }
}

