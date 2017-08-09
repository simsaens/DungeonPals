//
//  AppState.swift
//  Codea
//
//  Created by Simeon on 18/1/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit

protocol AppState
{
    func viewController() -> UIViewController
    
    static func transitionViewToState<T: UIViewController>(_ controller: T, state: Self) where T: StatefulViewProtocol, T.State == Self    
}
