//
//  LoginView.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import SwiftUI
import Combine

struct LoginView: View {

    @State private var isLoading = false
    @EnvironmentObject var loginViewModel:AppStore
    
    var body: some View {
        VStack {
            TextField("Username", text: $loginViewModel.username)
                .keyboardType(.emailAddress)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1.0)
                )
                .padding()
                
                
            
            SecureField("Password", text: $loginViewModel.password)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1.0)
                )
                .padding()
            
            
            if isLoading {
                ProgressView()
                    .padding()
            }
            
            if loginViewModel.loginFailed {
                Text("Invalid username or password")
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: login) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        
        .padding()
    }
       
        
    private func login() {
        guard !loginViewModel.username.isEmpty, !loginViewModel.password.isEmpty else {
            loginViewModel.loginFailed = true
            return
        }
        
        isLoading = true
        loginViewModel.loginFailed = false

        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            
            loginViewModel.getLoginData()
            
            DispatchQueue.main.async {
                self.isLoading = false
                if loginViewModel.isLoggedIn{
                    print("Loggin Success !!!!!")
                }                
            }
        }
    }
}
#Preview {
    LoginView()
}
