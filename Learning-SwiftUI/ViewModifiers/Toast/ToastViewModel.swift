//
//  ToastViewModel.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 03/01/24.
//

import Foundation

public class ToastViewModel: ObservableObject {
    private var workItem: DispatchWorkItem!
    private var dismissAction: (() -> Void)?
    private var duration: Int = 4
    
    @Published public var showToast = false {
        didSet {
            if self.showToast {
                self.workItem = DispatchWorkItem(block: {
                    if let dismissAction = self.dismissAction {
                        dismissAction()
                    }
                    self.showToast = false
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(self.duration), execute: self.workItem)
            }
        }
    }
    
    public init() {}
    
    public func toggleToast(duration: Int = 4, dismissAction: (() -> Void)? = nil) {
        self.duration = duration
        self.dismissAction = dismissAction
        if self.showToast {
            self.workItem.cancel()
            self.workItem = nil
        }
    }
    
}
