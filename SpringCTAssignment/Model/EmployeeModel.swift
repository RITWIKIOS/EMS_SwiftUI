//
//  EmployeeModel.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import SwiftUI
import Combine

// Employee Model
struct Employee: Identifiable, Codable {
    var id = UUID()
    var name: String
    var age: Int
    var addressLine: String
    var city: String
}

// Actions
enum EmployeeAction {
    case add(Employee)
}

// App State
struct AppState: Codable {
    var employees: [Employee] = []
}
