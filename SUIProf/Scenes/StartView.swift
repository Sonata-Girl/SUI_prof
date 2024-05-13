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
        static let loadingText = "Loading..."
    }

    @ObservedObject var viewModel = AppViewModel()
    @State var tapped = false
    @State var isDevelopersShown = false
    @State var isTextsAreShown = false
    @State var isLabelShown = false
    @State var isHaveAccountShow = false
    @State var isSignShow = false
    @State private var isLoading = false
    @State var textButton = Constants.loadingText
    @State var showLoginScreen = false

    var longTap: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .onEnded { _ in
                withAnimation {
                    self.tapped.toggle()
                    isDevelopersShown = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isDevelopersShown.toggle()
                        }
                    }
                }
            }
    }

    private var tapLoad: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                withAnimation {
                    self.isLoading = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.isLoading = false
                        self.showLoginScreen = true
                    }
                }
            }
    }

    var developersAlertView: some View {
        VStack {
            Text("Developers: Sonata :)")
                .foregroundStyle(.white)
            Button(role: .cancel) {
                withAnimation {
                    isDevelopersShown.toggle()
                }
            } label: {
                Text("Cancel")
                    .foregroundStyle(.orange)
            }
            .foregroundStyle(.white)
        }
        .frame(width: 200, height: 100)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.appGray)))
        .padding(.top, 100)
        .shadow(radius: 15)
    }

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
        if isLoading {
            ZStack {
                ZStack {
                    LinearGradient(
                        colors: [.appGreen, .appLightGreen],
                        startPoint: .leading,
                        endPoint: .trailing
                    ).ignoresSafeArea(.all)
                }
                VStack {
                    Text(Constants.loadingText)
                        .font(.bold(.custom(Constants.fontVerdana, size: 16))())
                        .foregroundStyle(.white)
                        .padding()
                    ProgressView()
                }
            }
        } else {
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
                    ZStack(alignment: .top) {
                        if isDevelopersShown {
                            developersAlertView
                                .transition(AnyTransition.slide)
                                .zIndex(1)
                        }
                        VStack {
                            Spacer()
                                .frame(height: 50)
                            Text(Constants.appName)
                                .font(.bold(.custom(Constants.fontVerdana, size: 40))())
                                .foregroundStyle(.white)
                                .padding()
                                .offset(x: isLabelShown ? 0 : -80)
                                .opacity(isLabelShown ? 1 : 0)
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
                            .gesture(longTap)
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
                                .offset(x: isHaveAccountShow ? 0 : -70)
                                .opacity(isHaveAccountShow ? 1 : 0)
                            NavigationLink {
                                LoginView()
                                    .environmentObject(viewModel)
                            } label: {
                                Text(Constants.signText)
                                    .font(.bold(.custom(Constants.fontVerdana, size: 28))())
                                    .foregroundStyle(.white)
                                    .padding(.zero)
                                    .offset(x: isSignShow ? 0 : -70)
                                    .opacity(isSignShow ? 1 : 0)
                                    .gesture(tapLoad)
                            }
                            NavigationLink(
                                destination: LoginView().environmentObject(viewModel),
                                isActive: $showLoginScreen
                            ) {
                            }
                            Divider()
                                .frame(width: 200, height: 1, alignment: .center)
                                .padding(.zero)
                                .overlay(.white)
                            Spacer()
                        }.blur(radius: isDevelopersShown ? 10 : 0)
                    }
                }.ignoresSafeArea()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.isLabelShown = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.isHaveAccountShow = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.isSignShow = true
                    }
                }
            }
        }
    }

    @State private var showingSheet = false
}
