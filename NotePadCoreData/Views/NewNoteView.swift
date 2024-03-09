//
//  NewNoteView.swift
//  NotePadCoreData
//
//  Created by Mehdi on 2024-03-09.
//

import SwiftUI

struct NewNoteView: View {
    
    @StateObject var viewModel = NewNoteViewViewModel()
    @Binding var isPresented: Bool
    
    @State var title: String = ""
    @State var content: String = ""
    @State var date: TimeInterval = Date().timeIntervalSince1970
    
    var body: some View {
        VStack{
            Text("Title")
            TextField("Write a title", text: $title)
                .padding()
            Text("Content")
            TextField("Write your content", text: $content)
                .padding()
            
            Button("Save") {
                addNote()
            }
        }
    }
        
    func addNote() {
        if title.isEmpty || content.isEmpty {
            return
        }
        
        let currentDate = Date(timeIntervalSince1970: date)
        viewModel.addNote(title: title, content: content, date: currentDate)
        title = ""
        content = ""
        isPresented = false // Dismiss the EditNoteView
    }
}

#Preview {
    NewNoteView(isPresented: .constant(false))
}
