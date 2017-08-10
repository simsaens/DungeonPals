//
//  ContactListViewModel.swift
//  Dungeon Pals
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import Foundation
import PromiseKit

class ContactListViewModel {
    
    private var names: [String] = []
    private let paths: [URL]
    private let path: URL

    let title = "Dungeon Pals"
    
    static let cellIdentifier = "ContactCell"
    
    var numberOfNames: Int {
        return names.count
    }
    
    init(path: URL) {
        self.path = path
        
        //Load names from path
        let paths = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [])
        
        self.paths = paths.filter { $0.pathExtension == "json" }
        self.names = self.paths.map { $0.deletingPathExtension().lastPathComponent }
    }
    
    func cellTitle(for rowIndex: Int) -> String {
        return names[rowIndex]
    }
    
    func cellSelected(for rowIndex: Int) -> Promise<DungeonPalsState> {
        return Promise {
            fulfil, reject in
            
            if let path = self.paths[safe: rowIndex],
                let contact = Contact(path: path) {
                fulfil(DungeonPalsState.profile(contact: contact))
            } else {
                reject(NSError(domain: "com.twolivesleft.Dungeon-Pals", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error loading contact!"]))
            }
        }
    }
    
    func nextStateForError(_ error: Error) -> DungeonPalsState {
        
        return .alert(title: "Dungeon Pal Error", message: error.localizedDescription)
        
    }
}
