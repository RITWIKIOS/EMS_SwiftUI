//
//  HomeScreen.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var store: AppStore
    
    
    var body: some View {
        NavigationView {
            VStack {
                // User Profile Section
                NavigationLink(destination: UserProfile().environmentObject(store)) {
                    Text("User Profile")
                    
                }
                
                // Add Employee Section
                NavigationLink(destination: AddEmployeeView().environmentObject(store)) {
                    Text("Add Employee")
                    
                }
                .padding()

            }
            .navigationTitle("Home")
        }
    }
}
