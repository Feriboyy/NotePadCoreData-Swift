//
//  NewNoteViewViewModel.swift
//  NotePadCoreData
//
//  Created by Mehdi on 2024-03-09.
//

import Foundation
import CoreData

class NewNoteViewViewModel: ObservableObject {
    
    @Published var notes: [Note] = []
    
    var container = Persistence.shared.container
    
    init () {
        
        self.fetchNotes()
        
    }
    func fetchNotes(){
        let request = NSFetchRequest<Note>(entityName: "Note")
        
        do{
            notes = try container.viewContext.fetch(request)

        } catch let error {
            print("error fetching: \(error)")
        }
        
    }
    
    func addNote(title: String, content: String, date: Date){
        let newNote = Note(context: container.viewContext)
        newNote.title = title
        newNote.content = content
        newNote.date = date
        saveData()
        
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            fetchNotes()
        } catch let error {
            print("error adding note: \(error)")
        }
    }
}
