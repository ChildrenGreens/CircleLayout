//
//  CircleLayout.swift
//  CircleLayout
//
//  Created by caiqiujun on 16/3/9.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

import UIKit

public let ITEM_SIZE:CGFloat = 70

class CircleLayout: UICollectionViewLayout {
    
    internal var center: CGPoint!
    internal var radius: CGFloat!
    internal var cellCount: Int!
    
    private var deleteIndexPaths:[NSIndexPath]?
    private var insertIndexPaths:[NSIndexPath]?
    
    override func prepareLayout() {
        // 初始化工作
        let size = collectionView!.frame.size
        cellCount = collectionView!.numberOfItemsInSection(0)
        center = CGPoint(x: size.width / 2, y: size.height / 2)
        radius = min(size.width, size.height) / 2.5
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.frame.size
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        // 计算每一个圆的位置
        let attributes = UICollectionViewLayoutAttributes.init(forCellWithIndexPath: indexPath)
        attributes.size = CGSize(width: ITEM_SIZE, height: ITEM_SIZE)
        attributes.center = CGPoint(
            x: center.x + radius * CGFloat(cosf(Float(2 * indexPath.item) * Float(M_PI) / Float(cellCount))),
            y: center.y + radius * CGFloat(sinf(Float(2 * indexPath.item) * Float(M_PI) / Float(cellCount))))
        return attributes
    }
    /**
     *  返回该区域内所有属性
    */
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesArray = [UICollectionViewLayoutAttributes]()
        for index in 0 ..< cellCount {
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            attributesArray.append(layoutAttributesForItemAtIndexPath(indexPath)!)
        }
        return attributesArray
    }
    
    
    
    override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
        deleteIndexPaths = [NSIndexPath]()
        insertIndexPaths = [NSIndexPath]()
        
        for updateItem in updateItems {
            if updateItem.updateAction == UICollectionUpdateAction.Delete {
                self.deleteIndexPaths!.append(updateItem.indexPathBeforeUpdate!)
            } else if updateItem.updateAction == UICollectionUpdateAction.Insert {
                self.insertIndexPaths!.append(updateItem.indexPathAfterUpdate!)
            }
        }
        
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        self.deleteIndexPaths = nil
        self.insertIndexPaths = nil
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        // 添加出现动画
        var attributes = super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath)
        
        if insertIndexPaths!.contains(itemIndexPath) {
            if attributes != nil {
                attributes = layoutAttributesForItemAtIndexPath(itemIndexPath)
                attributes?.alpha = 0.0
                attributes?.center = CGPointMake(center.x, center.y)
            }
        }
        
        
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        // 添加消失动画
        var attributes = super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath)
        
        if deleteIndexPaths!.contains(itemIndexPath) {
            if attributes != nil {
                attributes = layoutAttributesForItemAtIndexPath(itemIndexPath)
                
                attributes?.alpha = 0.0
                attributes?.center = CGPointMake(center.x, center.y)
                attributes?.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0)
            }
        }
        
        return attributes
    }
    
    

}
