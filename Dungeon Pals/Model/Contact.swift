//
//  Contact.swift
//  Dungeon Contacts
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import Foundation
import UIKit

struct Contact {
    
    enum CharacterType: String {
        case wizard = "wizard"
        case rogue = "rogue"
        case fighter = "fighter"
        case troll = "troll"
    }
    
    struct Stats {
        let strength: Int
        let intelligence: Int
        let dexterity: Int
    }
    
    let type: CharacterType
    let name: String
    let website: URL
    let email: String
    let stats: Stats
    
}


extension Contact {
    
    init?(path: URL) {
        
        do {
            let data = try Data(contentsOf: path)
            
            if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any] {
                
                self.name = path.deletingPathExtension().lastPathComponent
                self.type = Contact.CharacterType(rawValue: dict["type"] as? String ?? "") ?? .troll
                self.website = URL(string: dict["website"] as? String ?? "") ?? URL(fileURLWithPath: "")
                self.email = dict["email"] as? String ?? "None"                
                self.stats = Stats(dict: dict["stats"] as? [AnyHashable: Any] ?? [:])
                
            } else {
            
                return nil
            }
            
        } catch {
            return nil
        }
        
    }
    
}

extension Contact.Stats {
    
    init(dict: [AnyHashable: Any]) {
        
        self.strength = dict["str"] as? Int ?? 0
        self.intelligence = dict["int"] as? Int ?? 0
        self.dexterity = dict["dex"] as? Int ?? 0
    }
}


extension Contact.CharacterType {
    
    var image: UIImage? {
        switch self {
        case .wizard:
            return UIImage(named: "Wizard")
        case .rogue:
            return UIImage(named: "Rogue")
        case .troll:
            return UIImage(named: "Orc")
        case .fighter:
            return UIImage(named: "Barbarian")
        }
        
    }
    
}
