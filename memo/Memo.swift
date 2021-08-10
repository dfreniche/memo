//
//  Memo.swift
//  memo
//
//  Created by Diego Freniche Brito on 20/02/2021.
//

import Foundation
import ArgumentParser

@main
struct Memo: ParsableCommand {
    @Flag(help: "List all entries")
    var list = false
    
    @Argument(help: "This is the entry to save")
    var message: String?
    
    func run() throws {
        if (list) {
           listAllMessages()
        } else {
            guard let message = message else {
                
                print("You need a message. Try with --help")
                return
            }
            saveMessage(message: message)
        }
    }
    
    func saveMessage(message: String) {
        let entry = Entry()
        entry.text = message
        
        do {
            try RealmUtil.realm?.write {
                RealmUtil.realm?.add(entry)
            }
        } catch {
            fatalError("Error writing: \(error)")
        }
        
        
    }
    
    func listAllMessages() {
        guard let entries = RealmUtil.realm?.objects(Entry.self) else { return }
        guard entries.count > 0 else { return }
        
        print("Listing all \(entries.count) entries")
        
        entries.enumerated().forEach { (index, entry) in
            print("[ \(entry.timestamp) ] \(entry.text)")
        }
        
    }
}
