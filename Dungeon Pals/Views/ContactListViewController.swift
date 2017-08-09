//
//  ContactListViewController.swift
//  Dungeon Contacts
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit
import SnapKit

class ContactListViewController: StatefulViewController<DungeonPalsState>, UITableViewDelegate, UITableViewDataSource {

    private let viewModel: ContactListViewModel
    
    private let contactsTable = UITableView()
    
    init(state: DungeonPalsState, viewModel: ContactListViewModel) {
        self.viewModel = viewModel
        
        super.init(state: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
        
        title = viewModel.title
        
        contactsTable.register(UITableViewCell.self, forCellReuseIdentifier: ContactListViewModel.cellIdentifier)
        contactsTable.delegate = self
        contactsTable.dataSource = self
        contactsTable.backgroundColor = .clear
        contactsTable.separatorColor = #colorLiteral(red: 0.3589988426, green: 0.3723668981, blue: 0.4047743056, alpha: 1)
        
        view.addSubview(contactsTable)
        
        contactsTable.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
        }
    }
    
    //MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNames
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactListViewModel.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = viewModel.cellTitle(for: indexPath.row)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
    
    //MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Do selection
        viewModel.cellSelected(for: indexPath.row).then {
            nextState in
            
            DungeonPalsState.transitionViewToState(self, state: nextState)
        }.catch {
            error in
            
            DungeonPalsState.transitionViewToState(self, state: self.viewModel.nextStateForError(error))
        }
        
    }
}
