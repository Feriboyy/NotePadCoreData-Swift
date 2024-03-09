//
//  ContentView.swift
//  NotePadCoreData
//
//  Created by Mehdi on 2024-03-08.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewViewModel()
    @State private var isPresented = false
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(viewModel.notes){ entity in
                        NavigationLink(destination: Text(entity.title ?? "no title")) {
                            Text(entity.title ?? "no title")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.deleteNote(indexSet: indexSet)
                    })
                }
                
                Button("Add a new note") {
                    isPresented.toggle()
                }
                .sheet(isPresented: $isPresented) {
                    NewNoteView(isPresented: $isPresented)
                }
            }
            .padding()
        }
    }
    // Helper function to format date
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: date)
    }
}

#Preview {
    HomeView()
}
