//
//  AddEmployeeView.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import SwiftUI

struct AddEmployeeView: View {
    @EnvironmentObject var store: AppStore
    @State private var name = ""
    @State private var age = ""
    @State private var addressLine = ""
    @State private var city = ""
    @State private var failed = false
    
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Add Employee")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Address Line", text: $addressLine)
                    TextField("City", text: $city)
                    
                    if failed {
                        Text("Field should not be empty")
                            .foregroundColor(.red)
                            .padding(10)
                    }
                }
                
               
                Button(action: addEmployee) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                
            }
            
        }
        .navigationTitle("Add Employee")
    }
    
    
    private func addEmployee() {
        
        guard !name.isEmpty, !addressLine.isEmpty, !city.isEmpty, !age.isEmpty else {
            failed = true
            return
        }
        
        guard let age = Int(age) else { return }
        
        self.failed = false
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            
            let newEmployee = Employee(name: name, age: age, addressLine: addressLine, city: city)
            store.dispatch(action: .add(newEmployee))
            self.name = ""
            self.age = ""
            self.addressLine = ""
            self.city = ""
            
            
            
            
        }
        
        
    }
}
