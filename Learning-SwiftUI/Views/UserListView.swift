//
//  UserListView.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 02/01/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var userViewModel: UserViewModel = UserViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            UserHeaderView(headerString: "Users List", userViewModel: userViewModel)
            Spacer()
            switch userViewModel.userState {
            case .loading:
                loadingView
            case .failure:
                errorView
            case .success:
                UserList(userViewModel: userViewModel)
            }
        }
        .padding()
    }
    
    private var loadingView: some View {
        ProgressView()
    }
    
    private var errorView: some View {
        VStack {
            Image(systemName: "xmark.circle")
            Text(userViewModel.errorMessage)
        }
    }
    
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}


struct UserHeaderView: View {
    private var headerString: String
    private var userViewModel: UserViewModel
    
    init(headerString: String, userViewModel: UserViewModel) {
        self.headerString = headerString
        self.userViewModel = userViewModel
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(headerString)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                
            Spacer()
            Button(action: {
                self.userViewModel.fetchAllUsers()
            }) {
                HStack {
                    Image(systemName: "arrow.circlepath")
                    Text("Refresh")
                }
                .padding()
            }
        }
        .padding([.top, .leading], 20)
    }
}


struct UserList: View {
    @ObservedObject public var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(userViewModel.users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .nameModifier()
                            HStack {
                                Image(systemName: "envelope")
                                Text(user.email)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5.0)
                            HStack {
                                Image(systemName: "phone")
                                Text(user.phone)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5.0)
                            Divider()
                        }
                        .cornerRadius(6.0)
                    }
                }
            }
            .padding()
        }
    }
}


public struct NameViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.bold)
            .padding()
    }
}

extension View {
    func nameModifier() -> some View {
        modifier(NameViewModifier())
    }
}
