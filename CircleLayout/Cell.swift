//
//  Cell.swift
//  CircleLayout
//
//  Created by caiqiujun on 16/3/9.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

import UIKit



class Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 35.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.whiteColor().CGColor
        contentView.backgroundColor = UIColor.lightGrayColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
