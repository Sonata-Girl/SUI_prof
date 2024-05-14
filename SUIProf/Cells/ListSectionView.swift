//
//  ListSectionView.swift
//  SUIProf
//
//  Created by Sonata Girl on 08.05.2024.
//

import SwiftUI
/// Вью для отображения секции списка экрана профиля
struct ListSectionView: View {
    var text: String
    var imageName: String
    var badgeCount: Int
    var destination: AnyView?

    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .padding(.leading)
                NavigationLink {
                    destination
//                        .environmentObject(viewModel)
                } label: {
                    Text(text)
                        .font(.custom("Verdana", size: 20))
                        .foregroundStyle(.appGray)
//                        .padding()
                }
                .padding()
                Spacer()
                if badgeCount > 0 {
                    ZStack {
                    Circle().frame(width: 30, height: 30, alignment: .center)
                        .foregroundStyle(.linearGradient(colors: [.appLightGreen, .appGreen], startPoint: .top, endPoint: .bottom))
                        Text(String(badgeCount))
                            .foregroundStyle(.white)
                            .font(.custom("Verdana", size: 18))
                    }
                }
            }
            .frame(height: 35)
        }
    }
}
