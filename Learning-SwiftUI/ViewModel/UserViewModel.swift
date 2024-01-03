//
//  UserViewModel.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 02/01/24.
//
import Combine
import Foundation

enum UserState {
    case loading
    case failure
    case success
}

public class UserViewModel: ObservableObject {
    private(set) var users: [User] = []
    internal var cancellables = Set<AnyCancellable>()
    @Published private(set) var userState: UserState = .loading
    private(set) var errorMessage: String = ""
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        userState = .loading
        UserNetwork.shared.fetchAllUsers()
            .sink { [weak self] completion in
                if case let .failure(error) = completion, let errMessage = error as? LocalizedError {
                    guard let self = self else {
                        return
                    }
                    self.errorMessage = errMessage.localizedDescription
                    self.userState = .failure
                }
            } receiveValue: { [weak self] users in
                guard let self = self else {
                    return
                }
                self.users = users
                self.userState = .success
                let toastParam = ToastParam(message: "Fetched user data",
                                            actionText: "Clear",
                                            action: {
                    self.showClearToast()
                })
                NotificationCenter.default.post(name: .showToast, object: nil, userInfo: [ToastParamsKey: toastParam])
            }
            .store(in: &cancellables)
    }
    
    func showClearToast() {
        let toastParam = ToastParam(message: "Clear Toast")
        NotificationCenter.default.post(name: .showToast, object: nil, userInfo: [ToastParamsKey: toastParam])
    }
    
}
