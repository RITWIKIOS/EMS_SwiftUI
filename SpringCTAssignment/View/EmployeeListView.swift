//
//  EmployeeListView.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import SwiftUI

struct EmployeeListView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        List(store.state.employees) { employee in
            VStack(alignment: .leading) {
                Text(employee.name)
                    .font(.headline)
                Text("Age: \(employee.age)")
                Text(employee.addressLine)
                Text(employee.city)
            }
        }
        .navigationTitle("Employees")
    }
}
