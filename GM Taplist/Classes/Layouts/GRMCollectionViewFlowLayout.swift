//
//  GRMCollectionViewFlowLayout.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

protocol GRMCollectionViewFlowLayoutProtocol {
    func indexPathForSelectedCellForCollectionView(collectionView: UICollectionView, layout: UICollectionViewLayout) -> NSIndexPath?;
}

class GRMCollectionViewFlowLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
    private let selectedItemSize = CGSize(width: 320, height: 124)
    var delegate: GRMCollectionViewFlowLayoutProtocol?
    override required init() {
        super.init()
        sharedSetup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedSetup()
    }
    
    private func sharedSetup() {
        self.itemSize = CGSize(width: 320, height: 84)
    }
    
    func layoutAttributesForSelectedItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        attributes.size = selectedItemSize
        
        return attributes
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath == delegate?.indexPathForSelectedCellForCollectionView(collectionView, layout: collectionViewLayout) {
            return selectedItemSize
        } else {
            return itemSize
        }
    }
}