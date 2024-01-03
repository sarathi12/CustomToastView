//
//  HomeView.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 03/01/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var toastViewModel: ToastViewModel = ToastViewModel()
    @State private var toastParam: ToastParam?
    var body: some View {
        UserListView()
            .toast(toastViewModel: toastViewModel, toastParam: $toastParam)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
