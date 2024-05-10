//
//  ProfileView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 09.05.24.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 50)
                    Rectangle()
                        .fill(.white)
                        .ignoresSafeArea()
                        .overlay {
                            VStack {
                                profileInfo
                                Spacer()
                                    .frame(height: 47)
                                settingsList
                        }
                            
                    }
                }
            }
        }
    }
    
    private var profileInfo: some View {
        VStack {
            Image(.leo)
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            
            Text("Leo")
                .font(.system(size: 24, weight: .heavy))
                .foregroundStyle(.textGrey)
            HStack {
                Image(.point)
                Text("Yerevan")
            }
        }
        .padding(.top, 45)
    }
    
    private var settingsList: some View {
        List(profileViewModel.allSettings, id: \.name) { setting in
            
            makeSettingCellView(setting: setting)
        }
        .listStyle(.plain)
        .padding(.horizontal, 40)
    }
    
    private func makeSettingCellView(setting: Setting) -> some View {
        ZStack {
            NavigationLink(destination: {
                Text("Account/Payment")
            }) {
                Rectangle()
            }
            .opacity(0)
            
            HStack {
                Image(setting.iconName)
                Text(setting.name)
                Spacer()
                Image(setting.badge ?? "")
                
            }
            .foregroundStyle(.textGrey)
        }
    }
}

#Preview {
    ProfileView()
}

