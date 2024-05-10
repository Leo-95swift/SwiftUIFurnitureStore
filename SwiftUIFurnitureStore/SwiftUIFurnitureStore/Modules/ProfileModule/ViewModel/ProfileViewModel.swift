//
//  ProfileViewModel.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 10.05.24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    public var allSettings: [Setting] = [
        Setting(name: "Messages", iconName: "IconLetter", badge: "notification3"),
        Setting(name: "Notifications", iconName: "IconBell", badge: "notification4"),
        Setting(name: "Accounts Details", iconName: "IconProfile", badge: nil),
        Setting(name: "My purchases", iconName: "IconBasket", badge: nil),
        Setting(name: "Settings", iconName: "IconSettins", badge: nil)
    ]
    
}
