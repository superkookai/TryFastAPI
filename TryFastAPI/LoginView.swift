//
//  LoginView.swift
//  TryFastAPI
//
//  Created by Weerawut Chaiyasomboon on 8/1/2568 BE.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
            
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            
            TextField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            
            Button {
                login()
            } label: {
                Text("Login")
            }

        }
        .padding()
    }
    
    func login() {
        Task {
            do {
                try await APIServices.shared.login(username: username, password: password)
            } catch (let error) {
                print("Error Login: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    LoginView()
}
