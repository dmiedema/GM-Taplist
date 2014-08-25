//
//  OnTapDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

struct OnTapBeer: BeerData {
    var tapNumber: Int
    var tapLevel: Int
}

class OnTapDataSource: GRMCollectionViewDataSource {
    override let cellConfigurationBlock: (cell: GRMCollectionViewCell, data: OnTapBeer) -> ()

    private var beers = [OnTapBeer]()
    
    // MARK: Init
    required init(cellIdentifier: String, configurationBlock: (UICollectionViewCell, OnTapBeer) ->()) {
        self.cellIdentifier = cellIdentifier
        self.cellConfigurationBlock = configurationBlock
        super.init()
    }
    
    // MARK: Implementation
    override func itemForIndexPath(indexPath: NSIndexPath) -> OnTapBeer {
        return beers[indexPath.row]
    }

    func loadBeersForStore(storeID: Int) {
        delegate?.dataLoading()

        API.sharedInstance.beersOnTapForStore(storeID) { (onTapBeers) -> Void in
            self.beers = onTapBeers
            delegate?.dataLoaded()
        }
    }

    func loadBeersForStoreName(storeName: String) {
        let storeID = Store.storeIDForName(storeName, managedObjectContext!)
        
        self.loadBeersForStore(storeID)
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        cellConfigurationBlock(cell: cell, data: beers[indexPath.row])

        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }
    
    func collectionView(collectionView: UICollectionView!, viewForSupplementaryElementOfKind kind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionReusableView! {
        return nil
    }
}