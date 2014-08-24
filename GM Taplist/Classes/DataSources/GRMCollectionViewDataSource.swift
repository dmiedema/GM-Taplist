//
//  GRMCollectionViewDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/24/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

protocol GRMCollectionViewDataSourceDelegate {
    func dataLoading()
    func dataLoaded()
    func dataFailedToLoad(NSError)
}

protocol GRMCollectionViewDataSourceProtocol {
    func itemForIndexPath(indexPath: NSIndexPath) -> AnyObject
}