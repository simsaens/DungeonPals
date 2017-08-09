//
//  StatSlider.swift
//  Dungeon Pals
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit
import SnapKit

class StatSlider: UIControl {

    private let slider = UISlider()
    private let valueLabel = UILabel()
    private let titleLabel = UILabel()
    
    var value: Int {
        return Int(round(Double(slider.value)))
    }
    
    init(title: String, initialValue: Int) {
        super.init(frame: .zero)
        
        addSubview(slider)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.isContinuous = true
        
        slider.value = Float(initialValue)
        titleLabel.text = title
        
        slider.addTarget(self, action: #selector(sliderChanged(_ :)), for: .valueChanged)
        
        slider.thumbTintColor = #colorLiteral(red: 1, green: 0.4186053241, blue: 0.2168402778, alpha: 1)
        
        valueLabel.font = UIFont.boldSystemFont(ofSize: 50)
        
        valueLabel.textColor = #colorLiteral(red: 1, green: 0.4186053241, blue: 0.2168402778, alpha: 1)
        titleLabel.textColor = .white
        
        titleLabel.snp.makeConstraints {
            make in
            
            make.left.top.right.equalTo(self)
        }
        
        slider.snp.makeConstraints {
            make in
            
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(self).inset(12)
            make.height.equalTo(44)
            make.bottom.equalTo(valueLabel.snp.bottom)
        }
        
        valueLabel.snp.makeConstraints {
            make in
            
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(slider.snp.right).offset(20)
            make.right.equalTo(self).inset(12)
            make.bottom.equalTo(self)
            make.width.equalTo(58)
        }
        
        updateValueLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sliderChanged(_ sender: UISlider) {
        updateValueLabel()
        
        sendActions(for: .valueChanged)
    }
    
    private func updateValueLabel() {
        let numberFormatter = NumberFormatter()
        valueLabel.text = numberFormatter.string(from: NSNumber(integerLiteral: value))
    }
    
}
