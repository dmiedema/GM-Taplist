//
//  GRMCollectionViewController.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/23/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMCollectionViewController: UICollectionViewController, GRMCollectionViewDataSourceDelegate, GRMCollectionViewCellProtocol {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - DataSource's creation
    lazy var onTapDataSource: OnTapDataSource? = {
        let dataSource = OnTapDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.OnTapCellReuseIdentifier, configurationBlock: { (cell, beerData) -> () in
            cell.delegate = self
            cell.beerData = beerData
            
            cell.topLineLabel.text = beerData.onTapDisplayString()
            cell.middleLineLabel.attributedText = beerData.attributedStringForBreweryInformation()
            cell.bottomLineLabel.text = beerData.onTapBottomLineString()
        })
        return dataSource
    }()
    lazy var favoritesDataSource: FavoritesDataSource? = {
        let dataSource = FavoritesDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.FavoritesCellReuseIdentifier, configurationBlock: { (cell, beerData) -> () in
            cell.delegate = self
            cell.beerData = beerData
            
            cell.topLineLabel.text = beerData.allBeersDisplayString()
            cell.middleLineLabel.attributedText = beerData.attributedStringForBreweryInformation()
            cell.bottomLineLabel.text = beerData.allBeersBottomLineString()
        })
        return dataSource
    }()
    lazy var allBeersDataSource: AllBeersDataSource? = {
        let dataSource = AllBeersDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.AllBeersCellReuseIdentifier, configurationBlock: { (cell, beerData) -> () in
            cell.delegate = self
            cell.beerData = beerData
            
            cell.topLineLabel.text = beerData.allBeersDisplayString()
            cell.middleLineLabel.attributedText = beerData.attributedStringForBreweryInformation()
            cell.bottomLineLabel.text = beerData.allBeersBottomLineString()
        })
        return dataSource
    }()
    // MARK: - Properties
    private var selectedIndexPath: NSIndexPath
    var managedObjectContext: NSManagedObjectContext
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onTapDataSource?.delegate = self
        favoritesDataSource?.delegate = self
        allBeersDataSource?.delegate  = self
        
        self.collectionView?.dataSource = onTapDataSource
        onTapDataSource?.loadBeersForStore(onTapDataSource!.lastViewedStoreID())
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

    // MARK: - Implementation
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let customCell = cell as GRMCollectionViewCell
        if ((collectionView.dataSource!.isEqual(onTapDataSource))) {
            let beerData = customCell.beerData
            customCell.setKegLevel(beerData.tapLevel!, animated: true)
        }
    }

    // MARK: - GRMCollectionViewDataSourceDelegate
    func dataLoading() {
        // Show loading HUD
    }
    func dataLoaded() {
        // Hide HUD
        collectionView?.reloadData()
    }
    func dataFailedToLoad(error: NSError) {
        // Show Error HUD
    }
    
    // MARK: - GRMCollectionViewCellProtocol
    func favoritePressed(beerData: BeerData) {
        let cell = collectionView?.cellForItemAtIndexPath(selectedIndexPath) as GRMCollectionViewCell
        if !beerData.beer.favorite.boolValue {
            API.sharedInstance.favoriteBeer(beerData.beer.id, completionBlock: { (success) -> () in
                cell.setFavorite(true, animated: true)
            }, failureBlock: { (error) -> () in
            })
        } else {
            API.sharedInstance.unFavoriteBeer(beerData.beer.id, completionBlock: { (success) -> () in
                cell.setFavorite(false, animated: true)
            }, failureBlock: { (error) -> () in
            })
        }
    }
    
    func detailsPressed(beerData: BeerData) {
        let detailsViewController = storyboard?.instantiateViewControllerWithIdentifier(GrowlMovement.GMTaplist.TableView.StoryboardIdentifier) as GRMBeerDetailsTableViewController
        detailsViewController.beerData = beerData
        detailsViewController.managedObjectContext = managedObjectContext
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}