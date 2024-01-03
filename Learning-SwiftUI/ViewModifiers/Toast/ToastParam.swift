//
//  ToastParam.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 03/01/24.
//

import Foundation

public struct ToastParam {
    public var message: String
    public var duration: Int = 4
    public var actionText: String?
    public var action: (() -> Void)?
    public var onDismissAction: (() -> Void)?
    
    public init(message: String, duration: Int = 4, actionText: String? = nil, action: ( () -> Void)? = nil, onDismissAction: ( () -> Void)? = nil) {
        self.message = message
        self.duration = duration
        self.actionText = actionText
        self.action = action
        self.onDismissAction = onDismissAction
    }
    
}
