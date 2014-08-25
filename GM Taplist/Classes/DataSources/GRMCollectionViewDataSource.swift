//
//  GRMCollectionViewDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/24/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class BeerData {
    var beer: Beer
    var tapNumber: Int?
    var tapLevel: Int?

    required init(beer: Beer, tapNumber: Int?, tapLevel: Int?) {
        self.beer = beer
        self.tapNumber = tapNumber
        self.tapLevel = tapLevel
    }
}

protocol GRMCollectionViewDataSourceDelegate {
    func dataLoading()
    func dataLoaded()
    func dataFailedToLoad(NSError)
}

protocol GRMCollectionViewDataSourceProtocol {
    func itemForIndexPath(indexPath: NSIndexPath) -> BeerData
}

class GRMCollectionViewDataSource: NSObject {

    let cellIdentifier: String
    let cellConfigurationBlock: (cell: GRMCollectionViewCell, data: BeerData) -> ()
    var delegate: GRMCollectionViewDataSourceDelegate?

    internal lazy var managedObjectContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()

    required init(cellIdentifier: String, configurationBlock: (UICollectionViewCell, BeerData) ->()) {
        self.cellIdentifier = cellIdentifier
        self.cellConfigurationBlock = configurationBlock
        super.init()
    }
}