//
//  ContactViewController.swift
//  Dungeon Pals
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit

class ContactViewController: StatefulViewController<DungeonPalsState> {

    private let viewModel: ContactViewModel        
    
    private let strengthStat: StatSlider
    private let intelligenceStat: StatSlider
    private let dexterityStat: StatSlider
    
    private let imageView: UIImageView
    
    init(state: DungeonPalsState, viewModel: ContactViewModel) {
        self.viewModel = viewModel
    
        strengthStat = StatSlider(title: viewModel.strengthTitle, initialValue: viewModel.strengthValue)
        intelligenceStat = StatSlider(title: viewModel.intelligenceTitle, initialValue: viewModel.intelligenceValue)
        dexterityStat = StatSlider(title: viewModel.dexterityTitle, initialValue: viewModel.dexterityValue)
        
        imageView = UIImageView(image: viewModel.image)
        imageView.contentMode = .scaleAspectFit
        
        super.init(state: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.barStyle = .blackTranslucent
                
        view.addSubview(strengthStat)
        view.addSubview(intelligenceStat)
        view.addSubview(dexterityStat)
        
        view.addSubview(imageView)
        
        let website = UIButton(type: .system)
        let contact = UIButton(type: .system)
        
        website.setTitle(viewModel.websiteButtonTitle, for: .normal)
        contact.setTitle(viewModel.contactButtonTitle, for: .normal)
        
        website.addTarget(self, action: #selector(websitePressed(_:)), for: .touchUpInside)
        contact.addTarget(self, action: #selector(contactPressed(_:)), for: .touchUpInside)
        
        view.addSubview(website)
        view.addSubview(contact)
        
        strengthStat.snp.makeConstraints {
            make in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            make.left.right.equalTo(view).inset(18)
        }
        
        intelligenceStat.snp.makeConstraints {
            make in
            
            make.top.equalTo(strengthStat.snp.bottom).offset(12)
            make.left.right.equalTo(view).inset(18)
        }
        
        dexterityStat.snp.makeConstraints {
            make in
            
            make.top.equalTo(intelligenceStat.snp.bottom).offset(12)
            make.left.right.equalTo(view).inset(18)
        }
        
        website.snp.makeConstraints {
            make in
            
            make.bottom.right.equalTo(view).inset(18)
        }
        
        contact.snp.makeConstraints {
            make in
            
            make.bottom.left.equalTo(view).inset(18)
        }
        
        imageView.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(view).inset(18)
            make.bottom.equalTo(contact.snp.top).inset(12)
        }
        
    }
    
    @objc private func websitePressed(_ sender: UIButton) {
        DungeonPalsState.transitionViewToState(self, state: viewModel.nextStateForWebsitePressed())
    }
    
    @objc private func contactPressed(_ sender: UIButton) {
        DungeonPalsState.transitionViewToState(self, state: viewModel.nextStateForContactPressed())
    }

}
