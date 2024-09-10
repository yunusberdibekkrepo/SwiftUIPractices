//
//  SwiftUIPracticesApp.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 11.04.2024.
//

import SwiftfulRouting
import SwiftUI

@main
struct SwiftUIPracticesApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

// Swipe back
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
