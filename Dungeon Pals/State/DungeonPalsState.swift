//
//  DungeonPalsState
//  Dungeon Pals
//
//  Created by Simeon on 18/1/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI
import SnapKit

enum DungeonPalsState: AppState {
    
    //Dungeon Contacts States
    
    case contactList(path: URL)
    
    case contact(contact: Contact)
    
    //Common States

    case alert(title: String, message: String)
    case share(items: [AnyObject])
    case email(toAddress: String, subject: String, body: String, delegate: AnyObject?)
    case web(url: URL)
    case dismiss(completion: (()->())?)
    
    func viewController() -> UIViewController
    {
        switch self
        {
            
        //Dungeon Contacts States
    
        case .contactList(let path):
            let list = ContactListViewController(state: self, viewModel: ContactListViewModel(path: path))
            let nav = UINavigationController(rootViewController: list)
            return nav
            
        case .contact(let contact):
            return ContactViewController(state: self, viewModel: ContactViewModel(contact: contact))
            
        //Common States
            
        case .alert(let title, let message):
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            return alert
            
        case .share(let items):
            let share = UIActivityViewController(activityItems: items, applicationActivities: nil)
            
            return share
            
        case .email(let toAddress, let subject, let body, let delegate):
            let controller = MFMailComposeViewController()
            controller.setToRecipients([toAddress])
            controller.setSubject(subject)
            controller.setMessageBody(body, isHTML: false)
            controller.mailComposeDelegate = delegate as? MFMailComposeViewControllerDelegate
            
            return controller
            
        case .web(let url):
            if #available(iOS 9.0, *) {
                let webController = SFSafariViewController(url: url)
                webController.view.tintColor = .black
                
                return webController
            } else {
                fatalError("WebView state should not access view controller on iOS 8 or earlier")
            }
            
        case .dismiss:
            fatalError("Dismiss state should not access view controller")
        }
    }
    
    static func transitionViewToState<T : UIViewController>(_ controller: T, state: T.State) where T : StatefulView, T.State == DungeonPalsState {
        let fromState = controller.state
        
        switch (state, fromState) {
        case (.email, _):
            if MFMailComposeViewController.canSendMail() {
                let vc = state.viewController()
                controller.present(vc, animated: true, completion: nil)
                
                if let vc = vc as? MFMailComposeViewController {
                    vc.navigationBar.barStyle = .black
                    vc.navigationBar.isTranslucent = false
                }
            }
        case (.share, _):
            fallthrough
        case (.alert, _):
            let vc = state.viewController()
            controller.present(vc, animated: true, completion: nil)
            
        case (.web(let url), _):
            if #available(iOS 9.0, *) {
                controller.present(state.viewController(), animated: true, completion: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        case (.dismiss(let completion), _):
            if let nav = controller.navigationController,
               nav.viewControllers.count > 1 {
                nav.popViewController(animated: true)
            } else {
                controller.dismiss(animated: true, completion: completion)
            }
            
        default:
            let viewController = state.viewController()
            if let nav = controller.navigationController,
               !(viewController is UINavigationController) {
                nav.pushViewController(viewController, animated: true)
            } else {
                controller.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    static func dismissView<T : UIViewController>(_ controller: T) where T : StatefulView {
        if let nav = controller.navigationController {
            nav.popViewController(animated: true)
        } else {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    static var initialState: DungeonPalsState {
        return .contactList(path: URL(fileURLWithPath: Bundle.main.bundlePath))
    }
}


