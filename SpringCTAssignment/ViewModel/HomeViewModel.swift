//
//  HomeViewModel.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import Combine

class AppStore: ObservableObject {
    var employees: [Employee] = []
    
    @Published  var state: AppState
    @Published var isLoggedIn: Bool
    @Published var loginData: LoginModel?
    @Published var loginFailed = false
    
    var username = ""
    var password = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(initialState: AppState = AppState()) {
        
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if let data = UserDefaults.standard.data(forKey: "appState"),
           let decodedState = try? JSONDecoder().decode(AppState.self, from: data) {
            self.state = decodedState
        } else {
            self.state = initialState
        }
        
        self.fetchUserData()
    }
    
    
    // Login API Call
    func getLoginData() {
        
        let param = [
            "email": self.username,
            "password": self.password,
        ]
        
        NetworkManager.shared.getData(endpoint:"login", parameters: param, type: LoginModel.self)
                .sink { completion in
                    switch completion {
                    case .failure(let err):
                        print("Error is \(err.localizedDescription)")
                    case .finished:
                        print("Finished")
                        self.isLoggedIn = true
                        self.saveUserData()
                    }
                }
                receiveValue: { [weak self] response in
                    self?.loginData = response
                    
                }
                .store(in: &cancellables)
            }
    
    func dispatch(action: EmployeeAction) {
        appReducer(state: &state, action: action)
        if let data = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(data, forKey: "appState")
        }
    }
    
    func appReducer(state: inout AppState, action: EmployeeAction) {
        switch action {
        case .add(let employee):
            state.employees.append(employee)
        }
    }
    func saveUserData(){
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
    }
    func fetchUserData(){
        if self.isLoggedIn == true{
            if UserDefaults.standard.object(forKey: "username") != nil {
                username = UserDefaults.standard.value(forKey: "username") as! String
            }
        }
    }
}
