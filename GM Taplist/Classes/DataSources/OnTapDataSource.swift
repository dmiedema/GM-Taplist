//
//  OnTapDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class OnTapDataSource: GRMCollectionViewDataSource, UICollectionViewDataSource {
    private var beers = [BeerData]()
    
    // MARK: Init
    required init(cellIdentifier: String, configurationBlock: (GRMCollectionViewCell, BeerData) ->()) {
        super.init(cellIdentifier: cellIdentifier, configurationBlock: configurationBlock)
    }
    
    // MARK: Implementation
    func itemForIndexPath(indexPath: NSIndexPath) -> BeerData {
        return beers[indexPath.row]
    }

    func loadBeersForStore(storeID: Int) {
        delegate?.dataLoading()

        API.sharedInstance.beersOnTapForStore(storeID, completionBlock: { (onTapBeers) -> Void in
            self.beers = onTapBeers
            self.delegate?.dataLoaded()
        }, failureBlock: { (error) -> Void in
//            self.delegate?.dataFailedToLoad(error)
        })
    }

    func loadBeersForStoreName(storeName: String) {
        let (storeID: Int, error: NSError?) = Store.storeIDForName(storeName, inContext: managedObjectContext!)
        
        if error == nil && storeID > 0 {
            self.loadBeersForStore(storeID)
        } else {
            // error
        }
    }

    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        cellConfigurationBlock(cell: cell as GRMCollectionViewCell, data: beers[indexPath.row])

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView! {
        return nil
    }
}