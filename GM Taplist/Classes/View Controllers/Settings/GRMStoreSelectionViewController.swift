//
//  GRMStoreSelectionViewController.swift
//  GM Taplist
//
//  Created by Daniel on 1/17/15.
//  Copyright (c) 2015 Growl Movement. All rights reserved.
//

import Foundation

protocol GRMStoreSelection {
    func selectedStoreWithID(storeID: Int)
}

class GRMStoreSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var setPreferredStores = false
    var storeSelectionDelegate: GRMStoreSelection?
    
    // MARK: Outlets
    @IBOutlet weak var backgroundView: UIVisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    // MARK: Constraints
    @IBOutlet weak var centerXTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerYTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: Private
    private let CellReuseIdentifier = "CellIdentifier"
    private lazy var context: NSManagedObjectContext = {
        return ANDYDataManager.sharedManager().mainContext
    }()
    private lazy var stores: [GRMStore] = {
        return GRMStore.allStoresInContext(self.context) as [GRMStore]
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 8.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableViewHeightConstraint.constant = stores.count >= 6 ? CGFloat(44 * 6) : CGFloat(stores.count * 44)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        return cell
    }
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if setPreferredStores {
            
        } else {
            storeSelectionDelegate?.selectedStoreWithID(Int(stores[indexPath.row].store_id))
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Implementation
    
}