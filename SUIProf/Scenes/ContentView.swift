//
//  ContentView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AppViewModel()

    var body: some View {
        StartView()
//        ProfileView()
//        GoodCellView(good: Binding(get: {
//            Good(imageName: "thirdGood", goodName: "Bed", price: 1000, oldPrice: 2000, count: 0)
//        }, set: { newValue in
//            print()
//        }))
//        GoodsView()
//            .environmentObject(viewModel)
//        FiltersView()
//            .environmentObject(viewModel)
//        PaymentView()
    }
}

#Preview {
    ContentView()
}

