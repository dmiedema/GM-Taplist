//
//  GRMCollectionViewController.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/23/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMCollectionViewController: UICollectionViewController, GRMCollectionViewDataSourceDelegate {

//    lazy var dataSource: OnTapDataSource? = {
//    }()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
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
    override func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {

    }
    
    override func collectionView(collectionView: UICollectionView!, willDisplayCell cell: UICollectionViewCell!, forItemAtIndexPath indexPath: NSIndexPath!) {

    }

    // MARK: GRMCollectionViewDataSourceDelegate
    func dataLoading() {

    }
    func dataLoaded() {

    }
    func dataFailedToLoad(error: NSError) {

    }
}