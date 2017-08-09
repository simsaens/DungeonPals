//
//  StatefulView.swift
//  Codea
//
//  Created by Simeon on 18/1/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit

protocol StatefulView
{
    associatedtype State
    
    var state: State {
        get
    }
}

class StatefulViewController<T>: UIViewController, StatefulView
{
    typealias State = T
    
    private let _state: T
    
    var state: T {
        get {
            return _state
        }
    }
    
    init(state: T)
    {
        _state = state
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}


