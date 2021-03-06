//
//  OnTapDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class OnTapDataSource: GRMCollectionViewDataSource, GRMCollectionViewDataSourceProtocol,  UICollectionViewDataSource {
    
  private var beers = [BeerData]()
  
  // MARK: - Init
  required init(cellIdentifier: String, configurationBlock: (GRMCollectionViewCell, BeerData) ->()) {
    super.init(cellIdentifier: cellIdentifier, configurationBlock: configurationBlock)
  }
  
  // MARK: - Implementation
  func itemForIndexPath(indexPath: NSIndexPath) -> BeerData {
    return beers[indexPath.row]
  }

  func lastViewedStoreID() -> Int {
    return NSUserDefaults.standardUserDefaults().integerForKey(GrowlMovement.GMTaplist.UserDefaults.LastViewedStore)
  }
  
  func loadBeersForStore(storeID: Int) {
      delegate?.dataLoading()

      API.sharedInstance.beersOnTapForStore(storeID, completionBlock: { (onTapBeers) -> Void in
        self.beers = onTapBeers
        self.delegate?.dataLoaded()
      }, failureBlock: { (error) -> Void in
//            self.delegate?.dataFailedToLoad(error as NSError)
      })
  }

  func loadBeersForStoreName(storeName: String) {
      let storeID = GRMStore.storeIDForName(storeName, inContext: context)
      
      if storeID > 0 {
        self.loadBeersForStore(storeID)
      } else {
        self.delegate?.dataFailedToLoad(NSError(domain: GrowlMovement.GMTaplist.Errors.Generic, code: 15, userInfo: nil))
      }
  }

  // MARK: - UICollectionViewDataSource
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! GRMCollectionViewCell
    cellConfigurationBlock(cell: cell, data: beers[indexPath.row])

    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return beers.count
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return UICollectionReusableView()
  }
}