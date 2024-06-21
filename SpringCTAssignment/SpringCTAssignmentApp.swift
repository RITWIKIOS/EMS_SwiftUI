//
//  SpringCTAssignmentApp.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import SwiftUI

@main
struct SpringCTAssignmentApp: App {
    @State private var showSplashScreen = true
    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                MainView()
            }
        }
    }
}
