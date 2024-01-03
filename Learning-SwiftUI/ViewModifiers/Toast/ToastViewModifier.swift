//
//  ToastViewModifier.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 03/01/24.
//

import Foundation
import SwiftUI

public struct ToastViewModifier: ViewModifier {
    @ObservedObject var toastViewModel: ToastViewModel
    @Binding var toastParam: ToastParam?
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            VStack {
                Spacer()
                ToastView(message: toastParam?.message ?? "", actionText: toastParam?.actionText, action: toastParam?.action, hideToast: {
                    toastViewModel.showToast = false
                })
                .padding(.horizontal, 16)
                .padding(.bottom, 60)
            }
            .isHidden(!toastViewModel.showToast)
        }
        .onReceive(NotificationCenter.default.publisher(for: .showToast)) { notification in
            guard let toastParam = notification.userInfo?[ToastParamsKey] as? ToastParam else { return }
            self.toastParam = toastParam
            self.toastViewModel.toggleToast(duration: self.toastParam?.duration ?? 4, dismissAction: self.toastParam?.onDismissAction)
            self.toastViewModel.showToast = true
        }
    }
}

public extension View {
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}

public struct ToastView: View {
    let message: String
    let actionText: String?
    let action: (() -> Void)?
    let hideToast: (() -> Void)
    
    public init(message: String, actionText: String?, action: (() -> Void)?, hideToast: (@escaping () -> Void)) {
        self.message = message
        self.actionText = actionText
        self.action = action
        self.hideToast = hideToast
    }
    
    public var body: some View {
        HStack(alignment: .center) {
            Text(message)
                .font(.subheadline)
                .frame(maxHeight: .infinity)
                .foregroundColor(.white)
            if let actionText = self.actionText, let action = self.action {
                Spacer(minLength: 4)
                Button {
                    hideToast()
                    action()
                } label: {
                    Text(actionText)
                        .font(.footnote.bold())
                        .foregroundColor(.blue)
                        .frame(maxHeight: .infinity)
                    
                }
            } else {
                Spacer()
            }
        }
        .padding()
        .fixedSize(horizontal: false, vertical: true)
        .background(.gray)
        .cornerRadius(8.0)
    }
}

extension View {
    func toast(toastViewModel: ToastViewModel, toastParam: Binding<ToastParam?>) -> some View {
        modifier(ToastViewModifier(toastViewModel: toastViewModel, toastParam: toastParam))
    }
}

