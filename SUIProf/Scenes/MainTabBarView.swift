//
//  MainTabBarView.swift
//  SUIProf
//
//  Created by Sonata Girl on 08.05.2024.
//

import SwiftUI

struct MainTabBarView: View {

    enum Constants {
        static let shopImageName = "shopBarButton"
        static let basketImageName = "basketBarButton"
        static let profileImageName = "profileBarButton"
    }

    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        TabView(selection: $tableSelected) {
            GoodsView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(Constants.shopImageName)
                        .padding(.top)
                }.tag(0)
            ProfileView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(Constants.basketImageName)
                        .padding(.top)
                }.tag(1)
            ProfileView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(Constants.profileImageName)
                        .padding(.top)
                }.tag(2)
        }
        .tint(.appLightGreen)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .appLightGreen3
            UITabBar.appearance().barTintColor = .appLightGreen3
        }
    }

    @State var tableSelected = 0
}
