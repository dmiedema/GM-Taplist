//
//  AllBeersDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/24/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class AllBeersDataSource: GRMCollectionViewDataSource, GRMCollectionViewDataSourceProtocol, UICollectionViewDataSource {
    
  private var beers = [BeerData]()

  // MARK: - Init
  required init(cellIdentifier: String, configurationBlock: (GRMCollectionViewCell, BeerData) ->()) {
    super.init(cellIdentifier: cellIdentifier, configurationBlock: configurationBlock)
  }
  
  // MARK: - Implementation
  func itemForIndexPath(indexPath: NSIndexPath) -> BeerData {
    return beers[indexPath.row]
  }

  func loadBeersForStore(storeID: Int) {
    delegate?.dataLoading()
  }

  // MARK: - UICollectionViewDataSource
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
    cellConfigurationBlock(cell: cell as! GRMCollectionViewCell, data: beers[indexPath.row])

    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return beers.count
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return UICollectionReusableView()
  }

}