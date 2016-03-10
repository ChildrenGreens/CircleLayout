//
//  ViewController.swift
//  CircleLayout
//
//  Created by caiqiujun on 16/3/9.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    internal var cellCount = 20
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        
        collectionView?.addGestureRecognizer(tapGesture)
        collectionView?.registerClass(Cell.self, forCellWithReuseIdentifier: "MY_CELL")
        collectionView?.reloadData()
        collectionView?.backgroundColor = UIColor.lightGrayColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MY_CELL", forIndexPath: indexPath)
        return cell
    }
    
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Ended {
            let initialPinchPoint = gesture .locationInView(collectionView)
            let tappedCellPath = collectionView?.indexPathForItemAtPoint(initialPinchPoint)
            if (tappedCellPath != nil) {
                cellCount--
                collectionView?.performBatchUpdates({ () -> Void in
                    self.collectionView!.deleteItemsAtIndexPaths([tappedCellPath!])
                    }, completion: nil)
            } else {
                cellCount++
                collectionView?.performBatchUpdates({ () -> Void in
                    self.collectionView!.insertItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
                    }, completion: nil)
            }
            
            
        }
    }
    
}

