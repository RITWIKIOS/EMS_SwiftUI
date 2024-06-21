//
//  MainView.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject private var store = AppStore()
    
    
    var body: some View {
        
        if store.isLoggedIn {
            TabView {
                HomeScreen()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .environmentObject(store) // Pass the store to HomeView
                
                
                EmployeeListView()
                    .tabItem {
                        Label("Employees", systemImage: "person.3")
                    }
                    .environmentObject(store) // Pass the store to EmployeeListView
            }
        }else {
            LoginView()
                   .environmentObject(store)
        }
    }
}
