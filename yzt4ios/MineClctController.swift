//
//  MineClctController.swift
//  yzt4ios
//
//  Created by JasonFu on 15-3-16.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import UIKit
class MineClctController : UICollectionViewController{
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mineClctCell", forIndexPath: indexPath) as MineClctCell
        //如果是复用的Cell,viewWithTag就不会返回nil		

        cell.Title!.text = "/(indexPath.item)"
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {//#warning Incomplete method implementation -- Return the number of items in the section
        return 50
    }

}
