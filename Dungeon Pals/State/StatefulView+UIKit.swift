//
//  StatefulView+UIKit.swift
//  Dungeon Contacts
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit
import MessageUI

extension UIAlertController: StatefulView
{
    typealias State = DungeonPalsState
    
    var state: State {
        return DungeonPalsState.alert(title: "", message: "")
    }
}

extension MFMailComposeViewController: StatefulView
{
    typealias State = DungeonPalsState
    
    var state: State {
        return DungeonPalsState.email(toAddress: "", subject: "", body: "", delegate: nil)
    }
}
