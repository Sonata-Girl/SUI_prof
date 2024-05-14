//
//  ProfileView.swift
//  SUIProf
//
//  Created by Sonata Girl on 08.05.2024.
//

import SwiftUI
/// Экран профиля
struct ProfileView: View {

    enum Constants {
        static let avatarImageName = "avatar"
        static let yourNameText = "Your Name"
        static let verdanaFont = "Verdana"
        static let geoIconName = "geolocation"
        static let sityText = "Sity"
        static let notificationText = "Notification"
        static let accountDetailsText = "Accounts Details"
        static let myPurchasesDetailsText = "My purchases"
        static let settingsText = "Settings"
        static let mailImageName = "mail"
        static let notificationImageName = "notification"
        static let userImageName = "user"
        static let basketImageName = "basket"
        static let settingsImageName = "settings"
    }

//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack {
                    VStack {
                        ZStack {
                            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                        }
                    }
                    .ignoresSafeArea()
                    .frame(height: 50)
                    VStack {
                        Image(Constants.avatarImageName)
                        Text(Constants.yourNameText)
                            .font(.bold(.custom(Constants.verdanaFont, size: 24))())
                        HStack {
                            Image(Constants.geoIconName)
                            Text(Constants.sityText)
                                .font(.custom(Constants.verdanaFont, size: 20))
                        }
                        List {
                            ListSectionView(text: Constants.sityText, imageName: Constants.mailImageName, badgeCount: 3)
                            ListSectionView(text: Constants.notificationText, imageName: Constants.notificationImageName, badgeCount: 4)
                            ListSectionView(text: Constants.accountDetailsText, imageName: Constants.userImageName, badgeCount: 0, destination: AnyView(PaymentView()))
                            ListSectionView(text: Constants.myPurchasesDetailsText, imageName: Constants.basketImageName, badgeCount: 0)
                            ListSectionView(text: Constants.settingsText, imageName: Constants.settingsImageName, badgeCount: 0)
                        }
                        .listStyle(.plain)
                        .padding(.trailing, 40)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
