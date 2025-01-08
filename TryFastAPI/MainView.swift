//
//  MainView.swift
//  TryFastAPI
//
//  Created by Weerawut Chaiyasomboon on 8/1/2568 BE.
//

import SwiftUI

struct MainView: View {
    @State private var apiServices = APIServices.shared
    
    var body: some View {
        ZStack {
            if apiServices.token == nil {
                LoginView()
            } else {
                TodoListView()
            }
        }
    }
}

#Preview {
    MainView()
}
