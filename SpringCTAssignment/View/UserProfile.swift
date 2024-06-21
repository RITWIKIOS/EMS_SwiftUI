//
//  UserProfile.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import SwiftUI


struct UserProfile: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack{
            Text("Email: " + store.username)
        }
       
    }
}

#Preview {
    ContentView()
}

