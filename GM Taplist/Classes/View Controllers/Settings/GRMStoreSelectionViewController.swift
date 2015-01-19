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
    var backgroundView: UIView!
    var tableView: UITableView!
    // MARK: Constraints
    var centerXTableViewConstraint: NSLayoutConstraint!
    var centerYTableViewConstraint: NSLayoutConstraint!
    var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: Private
    private let CellReuseIdentifier = "CellIdentifier"
    private lazy var context: NSManagedObjectContext = {
        return ANDYDataManager.sharedManager().mainContext
    }()
    private lazy var stores: [GRMStore] = {
        return GRMStore.allStoresInContext(self.context) as [GRMStore]
    }()
    private lazy var preferredStores: [GRMStore] = {
        return GRMStore.preferredStoresInContext(self.context) as [GRMStore]
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundView()
        setupTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = stores[indexPath.row].city
        
        return cell
    }
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedStore = stores[indexPath.row]
        if setPreferredStores {
            var cell = tableView.cellForRowAtIndexPath(indexPath)
            if preferredStores.filter({$0 == selectedStore}).count == 0 {
                selectedStore.preferred_store = true
                cell?.accessoryType = .Checkmark
            } else {
                selectedStore.preferred_store = false
                cell?.accessoryType = .None
            }
        } else {
            storeSelectionDelegate?.selectedStoreWithID(Int(selectedStore.store_id))
        }
        ANDYDataManager.sharedManager().persistContext()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Implementation
    
    func removePopOver() {
        NSLog("RemovePopOver")
        dismissAnimated(true)
    }
    
    func showAnimated(animated: Bool) {
        let duration = animated ? 0.5 : 0.0
        
        let translation = CGAffineTransformMakeTranslation(-CGRectGetWidth(self.view.frame), -(CGRectGetHeight(self.view.frame)))
        let rotation = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        
        tableView.transform = CGAffineTransformConcat(rotation, translation)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.tableView.transform = CGAffineTransformIdentity
            self.view.alpha = 1.0
        }) { (complete) -> Void in }
    }
    
    func dismissAnimated(animated: Bool) {
        let duration = animated ? 0.5 : 0.0
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .BeginFromCurrentState, animations: { () -> Void in
            let translation = CGAffineTransformMakeTranslation(-CGRectGetWidth(self.view.frame), -(CGRectGetHeight(self.view.frame)))
            let rotation = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.tableView.transform = CGAffineTransformConcat(rotation, translation)
            
            self.view.alpha = 0.0
        }) { (complete) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
    }
    
    // MARK: Private
    private func tableViewHeight() -> CGFloat {
        return stores.count >= 6 ? CGFloat(44 * 6) : CGFloat(stores.count * 44)
    }
    
    private func setupBackgroundView() {
        backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
        backgroundView.setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "removePopOver"))
        
        self.view.addSubview(backgroundView)
        applyBackgroundViewConstraints()
    }
    
    private func setupTableView() {
        let width = min(CGRectGetWidth(self.view.frame), 300)
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: tableViewHeight()), style: .Plain)
        tableView.center = self.view.center
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellReuseIdentifier)
        
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 8.0
        
        self.view.addSubview(tableView)
        applyTableViewConstraints()
    }
    
    private func applyBackgroundViewConstraints() {
        let top = NSLayoutConstraint(item: backgroundView, attribute: .Top, relatedBy: .Equal, toItem: backgroundView.superview, attribute: .Top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: backgroundView, attribute: .Left, relatedBy: .Equal, toItem: backgroundView.superview, attribute: .Left, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: backgroundView, attribute: .Bottom, relatedBy: .Equal, toItem: backgroundView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: backgroundView, attribute: .Right, relatedBy: .Equal, toItem: backgroundView.superview, attribute: .Right, multiplier: 1, constant: 0)
        
        backgroundView.superview?.addConstraints([top, left, bottom, right])
        backgroundView.superview?.layoutIfNeeded()
    }
    
    private func applyTableViewConstraints() {
        let widthConstant = min(CGRectGetWidth(self.view.frame), 300)
        let heightConstant: CGFloat = tableViewHeight()
        
        centerXTableViewConstraint = NSLayoutConstraint(item: tableView, attribute: .CenterX, relatedBy: .Equal, toItem: tableView.superview, attribute: .CenterX, multiplier: 1, constant: 0)
        centerYTableViewConstraint = NSLayoutConstraint(item: tableView, attribute: .CenterY, relatedBy: .Equal, toItem: tableView.superview, attribute: .CenterY, multiplier: 1, constant: 0)
        tableViewHeightConstraint = NSLayoutConstraint(item: tableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: heightConstant)
        let width = NSLayoutConstraint(item: tableView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: widthConstant)
        
        tableView.superview?.addConstraints([centerXTableViewConstraint, centerYTableViewConstraint, tableViewHeightConstraint, width])
        tableView.superview?.layoutIfNeeded()
    }
}