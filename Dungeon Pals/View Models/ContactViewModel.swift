//
//  ContactViewModel.swift
//  Dungeon Pals
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ContactViewModel {
    
    private let contact: Contact
    
    var title: String {
        return contact.name
    }
    
    var image: UIImage? {
        return contact.type.image
    }
    
    let strengthTitle: String = "Strength 💪🏽"
    let intelligenceTitle: String = "Intelligence 👁"
    let dexterityTitle: String = "Dexterity 🗡"
    
    let websiteButtonTitle = "Visit Site"
    let contactButtonTitle = "Contact"
    
    var strengthValue: Int {
        return contact.stats.strength
    }
    
    var intelligenceValue: Int {
        return contact.stats.intelligence
    }
    
    var dexterityValue: Int {
        return contact.stats.dexterity
    }
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    func nextStateForContactPressed() -> DungeonPalsState {
        if MFMailComposeViewController.canSendMail() {
            return .email(toAddress: contact.email, subject: "Contact \(contact.name)", body: "", delegate: nil)
        }
        
        return .alert(title: "Can't Send Mail", message: "Can't send mail from this device")
    }
    
    func nextStateForWebsitePressed() -> DungeonPalsState {
        return .web(url: contact.website)
    }
}
