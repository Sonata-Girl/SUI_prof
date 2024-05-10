//
//  StartView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI
/// Стартовый экран приложения
struct StartView: View {

    enum Constants {
        static let appName = "169.ru"
        static let fontVerdana = "Verdana"
        static let imageLogoName = "logo"
        static let getStartedTExt = "Get Started"
        static let questionText = "Don't have an account?"
        static let signText = "Sign in here"
        static let imageLink = "https://live.staticflickr.com/8073/8307198852_878d4f319b_b.jpg"
    }

    @ObservedObject var viewModel = AppViewModel()

    private var asyncImageView: some View {
        AsyncImage(url: URL(string: Constants.imageLink)) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                        .accentColor(.accentColor)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 120, alignment: .center)
                        .cornerRadius(20)
                        .padding()
                case .failure(let error):
                    Image(Constants.imageLogoName)
                        .frame(width: 296, height: 121, alignment: .center)
                            .padding()
                    Text(error.localizedDescription)
                        .font(.headline)
                @unknown default:
                    fatalError()
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        .appLightGreen,
                        .appGreen
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                VStack {
                    Spacer()
                        .frame(height: 50)
                    Text(Constants.appName)
                        .font(.bold(.custom(Constants.fontVerdana, size: 40))())
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                        .frame(height: 50)
                    asyncImageView
                    Spacer()
                        .frame(height: 130)
                    Button {
                        showingSheet.toggle()
                    } label: {
                            Text(Constants.getStartedTExt)
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                                .foregroundStyle(.linearGradient(colors: [.appGreen,.appLightGreen], startPoint: .top, endPoint: .bottom))
                    }
                    .fullScreenCover(isPresented: $showingSheet, content: MainTabBarView.init)
                    .environmentObject(viewModel)
                    .frame(width: 300, height: 55)
                    .tint(.black)
                    .background(.white)
                    .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                    .cornerRadius(30)
                    .padding()
                    Spacer()
                        .frame(height: 70)
                    Text(Constants.questionText)
                        .font(.bold(.custom(Constants.fontVerdana, size: 16))())
                        .foregroundStyle(.white)
                        .padding()
                    NavigationLink {
                        LoginView()
                            .environmentObject(
                                viewModel
                            )
                    } label: {
                        Text(Constants.signText)
                            .font(.bold(.custom(Constants.fontVerdana, size: 28))())
                            .foregroundStyle(.white)
                            .padding(.zero)
                    }
                    Divider()
                        .frame(width: 200, height: 1, alignment: .center)
                        .padding(.zero)
                        .overlay(.white)
                    Spacer()
                }
            }.ignoresSafeArea()
        }
    }

    @State private var showingSheet = false
}
