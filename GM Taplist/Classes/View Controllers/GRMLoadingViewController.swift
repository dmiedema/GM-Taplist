//
//  GRMLoadingViewController.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 9/6/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMLoadingViewController: UIViewController {
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()

    let updateGroup: dispatch_group_t = dispatch_group_create()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        updateBeers()
//        updateBreweries()
//        updateStores()
        
        dispatch_group_notify(updateGroup, dispatch_get_main_queue()) { () -> Void in
            self.pushToFirstScreen()
        }
    }
    override func viewWillAppear(animated: Bool) {
        view.backgroundColor = UIColor.greenColor()
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    override func viewWillDisappear(animated: Bool) {
        
    }
    override func viewDidDisappear(animated: Bool) {
        
    }
    
    // MARK: -  Implementation
    func updateBeers() {
        NSLog("updateBeers()")
        dispatch_group_enter(updateGroup)
        let date = NSUserDefaults.standardUserDefaults().objectForKey(GrowlMovement.GMTaplist.UserDefaults.LastRetreivedBeerDate) as? NSDate
        API.sharedInstance.beers(date, completionBlock: { (beers: [GRMBeer]) -> () in
            dispatch_group_leave(self.updateGroup)
            }, failureBlock: { (error: NSError) -> () in
            dispatch_group_leave(self.updateGroup)
        })
    }
    
    func updateBreweries() {
        NSLog("updateBreweries()")
        dispatch_group_enter(updateGroup)
        let date = NSUserDefaults.standardUserDefaults().objectForKey(GrowlMovement.GMTaplist.UserDefaults.LastRetreivedBreweryDate) as? NSDate
        
        API.sharedInstance.breweries(date, completionBlock: { (breweries: [GRMBrewery]) -> () in
            dispatch_group_leave(self.updateGroup)
            }, failureBlock: { (error: NSError) -> () in
            dispatch_group_leave(self.updateGroup)
        })
    }
    
    func updateStyles() {
        let date = NSUserDefaults.standardUserDefaults().objectForKey(GrowlMovement.GMTaplist.UserDefaults.LastRetreivedStyleDate) as NSDate
        

    }
    
    func updateStores() {
        NSLog("updateStores()")
        dispatch_group_enter(updateGroup)
        API.sharedInstance.stores({ (stores: [GRMStore]) -> () in
            dispatch_group_leave(self.updateGroup)
            }, failureBlock: { (error: NSError) -> () in
            dispatch_group_leave(self.updateGroup)
        })
    }
    
    func pushToFirstScreen() {
        NSLog("pushToFirstScreen()")
        let collectionView = storyboard?.instantiateViewControllerWithIdentifier("GRMCollectionViewController") as GRMCollectionViewController

        navigationController?.pushViewController(collectionView, animated: true)

        navigationController?.setViewControllers([collectionView], animated: false)
    }
}