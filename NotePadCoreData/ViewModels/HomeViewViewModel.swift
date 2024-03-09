//
//  HomeViewViewModel.swift
//  NotePadCoreData
//
//  Created by Mehdi on 2024-03-08.
//

import Foundation
import CoreData

class HomeViewViewModel: ObservableObject{
    
    @Published var notes: [Note] = []
    
    var container = Persistence.shared.container
    
    private var fetchRequest: NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)] // Assuming "date" is your sort key
        return request
    }
    
    init(){
        fetchNotes()
        
        // Observe changes in the Core Data context
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidChange), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func fetchNotes(){
        do{
            notes = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("error fetching: \(error)")
        }
    }
    
    @objc private func contextDidChange() {
        fetchNotes()
    }
    
    func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = notes[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            // No need to fetch notes here, as contextDidChange will handle updates
        } catch let error {
            print("error adding note: \(error)")
        }
    }
}
