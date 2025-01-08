//
//  TodoListView.swift
//  TryFastAPI
//
//  Created by Weerawut Chaiyasomboon on 8/1/2568 BE.
//

import SwiftUI

struct TodoListView: View {
    @State private var todos: [Todos] = []
    
    var body: some View {
        NavigationStack {
            List(todos) { todo in
                TodoRowView(todo: todo)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Todos")
        }
        .onAppear {
            getTodos()
        }
    }
    
    func getTodos() {
        Task {
            do {
                self.todos = try await APIServices.shared.getTodos()
            } catch (let error) {
                print("Error get Todos: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    TodoListView()
}

struct TodoRowView: View {
    let todo: Todos
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(todo.title)
                    .font(.headline)
                Text(todo.description)
            }
            
            Spacer()
            
            VStack {
                Image(systemName: todo.complete ? "checkmark.circle" : "x.circle")
                    .imageScale(.large)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.secondary.opacity(0.4))
        )
    }
}

#Preview {
    TodoRowView(todo: Todos(id: 1, title: "Go to gym", description: "Exercise for good health", priority: 3, complete: false, ownerId: 1))
}
