//
//  GRMCollectionViewController.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/23/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMCollectionViewController: UICollectionViewController, GRMCollectionViewDataSourceDelegate, GRMCollectionViewCellProtocol, UICollectionViewDelegateFlowLayout {

    // MARK: - Init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - DataSource's creation
    lazy var onTapDataSource: OnTapDataSource = {
        let dataSource = OnTapDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.CellReuseIdentifier, configurationBlock: { (cell, beerData) -> () in
            cell.delegate = self
            cell.beerData = beerData
            
            cell.topLineLabel?.text = beerData.onTapDisplayString()
            cell.middleLineLabel?.attributedText = beerData.attributedStringForBreweryInformation()
            cell.bottomLineLabel?.text = beerData.onTapBottomLineString()
        })
        return dataSource
    }()
    lazy var favoritesDataSource: FavoritesDataSource = {
        let dataSource = FavoritesDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.CellReuseIdentifier, configurationBlock: { (cell, beerData) -> () in
            cell.delegate = self
            cell.beerData = beerData
            
            cell.topLineLabel.text = beerData.allBeersDisplayString()
            cell.middleLineLabel.attributedText = beerData.attributedStringForBreweryInformation()
            cell.bottomLineLabel.text = beerData.allBeersBottomLineString()
        })
        return dataSource
    }()
    lazy var allBeersDataSource: AllBeersDataSource = {
        let dataSource = AllBeersDataSource(cellIdentifier: GrowlMovement.GMTaplist.CollectionView.CellReuseIdentifier, configurationBlock: { (cell, beerData) -> () in
            cell.delegate = self
            cell.beerData = beerData
            
            cell.topLineLabel.text = beerData.allBeersDisplayString()
            cell.middleLineLabel.attributedText = beerData.attributedStringForBreweryInformation()
            cell.bottomLineLabel.text = beerData.allBeersBottomLineString()
        })
        return dataSource
    }()
    // MARK: - Properties
    // MARK: Private
    private var currentDataSource: GRMCollectionViewDataSourceProtocol!
    private var selectedIndexPath: NSIndexPath?
    private lazy var leftBarButton: UIBarButtonItem = {
        let title = NSLocalizedString("Settings", tableName: "GRMCollectionViewController", bundle: NSBundle.mainBundle(), value: "Settings", comment: "Settings")
        var barButton = UIBarButtonItem(title: title, style: .Plain, target: self, action: "leftBarButtonPressed:")
        return barButton
    }()
    private lazy var refreshControl: UIRefreshControl = {
        var control = UIRefreshControl()
        control.addTarget(self, action: "refreshItems", forControlEvents: .ValueChanged)
        return control
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()

        collectionView?.registerNib(UINib(nibName: "GRMCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GrowlMovement.GMTaplist.CollectionView.CellReuseIdentifier)
        
        onTapDataSource.delegate = self
        favoritesDataSource.delegate = self
        allBeersDataSource.delegate  = self
        
        collectionView?.dataSource = onTapDataSource
        currentDataSource = onTapDataSource
        onTapDataSource.loadBeersForStore(1)
        
        self.collectionView?.addSubview(self.refreshControl)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = leftBarButton
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    override func viewWillDisappear(animated: Bool) {

        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        super.viewDidDisappear(animated)
    }

    // MARK: -
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)

        collectionView?.collectionViewLayout.invalidateLayout()
    }
    // MARK: - Implementation
    // MARK: Collection View Delegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as GRMCollectionViewCell
        collectionView.bringSubviewToFront(cell)
        
        if selectedIndexPath == indexPath {
            collectionView.deselectItemAtIndexPath(selectedIndexPath, animated: true)
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }

        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as GRMCollectionViewCell
        
        selectedIndexPath = nil
        
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let _cell = cell as GRMCollectionViewCell
        if ((collectionView.dataSource!.isEqual(onTapDataSource))) {
            let beerData = _cell.beerData
//            customCell.setKegLevel(beerData.tapLevel!, animated: true)
            let level = Int(arc4random() % 100)
            _cell.setKegLevel(level, animated: true)
            NSLog("Keg level \(level)")
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if selectedIndexPath != nil {
            let cell = collectionView?.cellForItemAtIndexPath(selectedIndexPath!) as GRMCollectionViewCell
            collectionView?.deselectItemAtIndexPath(selectedIndexPath, animated: true)
            selectedIndexPath = nil
        }
    }
    
    // MARK: Actions
    func refreshItems() {
        if currentDataSource.isEqual(onTapDataSource) {
            onTapDataSource.loadBeersForStore(1)
        }
    }
    func leftBarButtonPressed(sender: UIBarButtonItem) {
        let settings = storyboard?.instantiateViewControllerWithIdentifier("GRMSettingsTableViewController") as  GRMSettingsTableViewController
        navigationController?.pushViewController(settings, animated: true)
    }
    
    // MARK: - UICollectionView Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let _width =  CGRectGetWidth(collectionView.bounds)
        var itemWidth :CGFloat;
        
        if _width < 568 {
            itemWidth = _width
        } else {
            itemWidth = _width / 2.0
        }
        
        NSLog("itemWidth: \(itemWidth)")
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? GRMCollectionViewCell
        cell?.cellContentsViewWidth.constant = itemWidth
        cell?.subviews.map() { $0.layoutIfNeeded() }
        cell?.layoutIfNeeded()
        
        return CGSize(width: itemWidth, height: 84)
    }
    
    // MARK: - GRMCollectionViewDataSourceDelegate
    var selectedItemIndexPath: NSIndexPath? {
        return self.selectedIndexPath?
    }
    func dataLoading() {
        // Show loading HUD
    }
    func dataLoaded() {
        // Hide HUD
        if refreshControl.refreshing { refreshControl.endRefreshing() }
        collectionView?.reloadData()
    }
    func dataFailedToLoad(error: NSError) {
        if refreshControl.refreshing { refreshControl.endRefreshing() }
        // Show Error HUD
    }
    
    // MARK: - GRMCollectionViewCellProtocol
    func cellPanEnded() {
        selectedIndexPath = nil
    }
    func cellPannedAtPoint(point: CGPoint) {
        selectedIndexPath = collectionView?.indexPathForItemAtPoint(point)
    }
    func favoritePressed(beerData: BeerData) {
        if selectedIndexPath == nil { return; }
        let indexPath = selectedIndexPath!
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as GRMCollectionViewCell
        let userID = NSUserDefaults.standardUserDefaults().integerForKey(GrowlMovement.GMTaplist.UserDefaults.LoggedInUserID)

        if userID == 0 {
            DeviceRegister.registerNewDevice()
            if let token = NSUserDefaults.standardUserDefaults().stringForKey(GrowlMovement.GMTaplist.UserDefaults.PushTokenKey) {
                API.sharedInstance.registerUserWithToken(token, completionBlock: { (user) -> () in
                    self.favoritePressed(beerData)
                }, failureBlock: { (error) -> () in
                    return
                })
            } else {
                NSLog("wtf no token")
                return
            }
        }
        
        if beerData.beer.favorite.boolValue == false {
            NSLog("Favoriting beer")
            API.sharedInstance.favoriteBeer(beerData.beer.beer_id as Int, completionBlock: { (success) -> () in
                cell.setFavorite(true, animated: true)
            }, failureBlock: { (error) -> () in
            })
        } else {
            NSLog("UnFavoriting beer")
            API.sharedInstance.unFavoriteBeer(beerData.beer.beer_id as Int, completionBlock: { (success) -> () in
                cell.setFavorite(false, animated: true)
            }, failureBlock: { (error) -> () in
            })
        }
    }
    
    func detailsPressed(beerData: BeerData) {
        let detailsViewController = storyboard?.instantiateViewControllerWithIdentifier(GrowlMovement.GMTaplist.TableView.StoryboardIdentifier) as GRMBeerDetailsTableViewController
        detailsViewController.beerData = beerData
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    // MARK: - GRMCollectionViewFlowLayoutProtocol
    func indexPathForSelectedCellForCollectionView(collectionView: UICollectionView, layout: UICollectionViewLayout) -> NSIndexPath? {
        return selectedIndexPath
    }
}