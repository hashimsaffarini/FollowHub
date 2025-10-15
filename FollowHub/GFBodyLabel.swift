//
//  CGBodyLabel.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 14/10/2025.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (textAligment : NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAligment
        configure()
    }
    
    private func configure() {
        textColor = .systemGray
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }


}
