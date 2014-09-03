//
//  GRMCollectionViewController.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/23/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMCollectionViewController: UICollectionViewController, GRMCollectionViewDataSourceDelegate {

    // MARK: DataSource's creation
    lazy var onTapDataSource: OnTapDataSource? = {
        let dataSource = OnTapDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.OnTapCellReuseIdentifier, configurationBlock: { (cell, beer) -> () in
            
        })
        return dataSource
    }()
    lazy var favoritesDataSource: FavoritesDataSource? = {
        let dataSource = FavoritesDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.FavoritesCellReuseIdentifier, configurationBlock: { (cell, beer) -> () in
            
        })
        return dataSource
    }()
    lazy var allBeersDataSource: AllBeersDataSource? = {
        let dataSource = AllBeersDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.AllBeersCellReuseIdentifier, configurationBlock: { (cell, beer) -> () in
            
        })
        return dataSource
    }()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        onTapDataSource?.delegate = self
        favoritesDataSource?.delegate = self
        allBeersDataSource?.delegate  = self
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(animated: Bool) {

        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
    }

    // MARK: Implementation
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {

    }

    // MARK: GRMCollectionViewDataSourceDelegate
    func dataLoading() {

    }
    func dataLoaded() {
        collectionView?.reloadData()
    }
    func dataFailedToLoad(error: NSError) {

    }
}