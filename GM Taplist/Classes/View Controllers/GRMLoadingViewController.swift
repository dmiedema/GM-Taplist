//
//  GRMLoadingViewController.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 9/6/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import UIKit

class GRMLoadingViewController: UIViewController {
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()

    @IBOutlet weak var imageView: UIImageView!
    let updateGroup: dispatch_group_t = dispatch_group_create()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBeers()
//        updateBreweries()
//        updateStores()
        
        dispatch_group_notify(updateGroup, dispatch_get_main_queue()) { () -> Void in
            self.pushToFirstScreen()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.whiteColor()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: .Repeat, animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.25, animations: { () -> Void in
                let rotate = CGFloat(M_PI * 90 / 180.0)
                self.imageView.transform = CGAffineTransformMakeRotation(rotate)
            })
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: { () -> Void in
                let rotate = CGFloat(M_PI * 180.0 / 180.0)
                self.imageView.transform = CGAffineTransformMakeRotation(rotate)
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.25, animations: { () -> Void in
                let rotate = CGFloat(M_PI * 270.0 / 180.0)
                self.imageView.transform = CGAffineTransformMakeRotation(rotate)
            })
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.25, animations: { () -> Void in
                let rotate = CGFloat(M_PI * 360.0 / 180.0)
                self.imageView.transform = CGAffineTransformMakeRotation(rotate)
            })
        }, completion: { (complete) -> Void in })
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
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