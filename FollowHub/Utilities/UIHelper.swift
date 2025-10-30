//
//  UIHelper.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 25/10/2025.
//

import UIKit

struct UIHelper {
    
   static func createThreeColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding : CGFloat = 12
        let itemMinimumItemSpacing : CGFloat = 10
        let availabelWidth = width - (padding * 2) - (itemMinimumItemSpacing * 2)
        let itemWidth  = availabelWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
