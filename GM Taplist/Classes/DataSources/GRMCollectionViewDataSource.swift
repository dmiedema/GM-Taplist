//
//  GRMCollectionViewDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/24/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

protocol BeerData {
    var beerID: Int
    var data: Beer
}

protocol GRMCollectionViewDataSourceDelegate {
    func dataLoading()
    func dataLoaded()
    func dataFailedToLoad(NSError)
}

protocol GRMCollectionViewDataSourceProtocol {
    func itemForIndexPath(indexPath: NSIndexPath) -> BeerData
}

class GRMCollectionViewDataSource: NSObject, UICollectionViewDataSource, GRMCollectionViewDataSourceProtocol {

    let cellIdentifier: String
    let cellConfigurationBlock: (cell: GRMCollectionViewCell, data: BeerData) -> ()

    public lazy var managedObjectContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()

    var delegate: GRMCollectionViewDataSourceDelegate?

    required init(cellIdentifier: String, configurationBlock: (UICollectionViewCell, BeerData) ->()) {
        self.cellIdentifier = cellIdentifier
        self.cellConfigurationBlock = configurationBlock
        super.init()
    }
    
    // MARK: GRMCollectionViewDataSourceProtocol
    func itemForIndexPath(indexPath: NSIndexPath) -> BeerData {
        return BeerData()
    }
}