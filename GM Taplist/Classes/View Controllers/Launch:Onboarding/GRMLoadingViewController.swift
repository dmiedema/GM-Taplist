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
    
    // MARK: Properties
    let updateGroup: dispatch_group_t = dispatch_group_create()
    private let topText = [
        "top label"
    ]
    private let bottomText = [
        "bottom label"
    ]
    
    private var topLbel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 22))
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    private var bottomLbel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 22))
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBeers()
        updateBreweries()
        updateStores()
        
        dispatch_group_notify(updateGroup, dispatch_get_main_queue()) { () -> Void in
            self.pushToFirstScreen()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBarHidden = true
        
        self.view.addSubview(self.topLbel)
        self.view.addSubview(self.bottomLbel)
        
        self.view.addConstraints(labelConstraints())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let randomIndex = Int(arc4random()) % topText.count
        
        NSLog("index \(randomIndex)")
    
        self.topLbel.text = topText[randomIndex] as String
        self.bottomLbel.text = bottomText[randomIndex] as String
        
        KVNProgress.show()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        KVNProgress.dismiss()
        
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    // MARK: -  Implementation
    func updateBeers() {
        NSLog("updateBeers()")
        dispatch_group_enter(updateGroup)
        let date = NSUserDefaults.standardUserDefaults().objectForKey(GrowlMovement.GMTaplist.UserDefaults.LastRetreivedBeerDate) as? NSDate
        API.sharedInstance.beers(date, completionBlock: { (beers: [GRMBeer]) -> () in
            dispatch_group_leave(self.updateGroup)
            }, failureBlock: { (error: NSError) -> () in
                NSLog("Error: \(error)")
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
        let date = NSUserDefaults.standardUserDefaults().objectForKey(GrowlMovement.GMTaplist.UserDefaults.LastRetreivedStyleDate) as! NSDate
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
        let collectionView = storyboard?.instantiateViewControllerWithIdentifier("GRMCollectionViewController") as! GRMCollectionViewController

        navigationController?.pushViewController(collectionView, animated: true)

        navigationController?.setViewControllers([collectionView], animated: false)
    }
    
    private func labelConstraints() -> [NSLayoutConstraint] {
        let topCenterXConstraint = NSLayoutConstraint(item: self.topLbel, attribute: .CenterX, relatedBy: .Equal, toItem: self.topLbel.superview, attribute: .CenterX, multiplier: 1, constant: 0)
        let bottomCenterXConstraint = NSLayoutConstraint(item: self.bottomLbel, attribute: .CenterX, relatedBy: .Equal, toItem: self.bottomLbel.superview, attribute: .CenterX, multiplier: 1, constant: 0)
        
        let topSpace = NSLayoutConstraint(item: self.topLbel, attribute: .Top, relatedBy: .Equal, toItem: self.topLbel.superview, attribute: .TopMargin, multiplier: 1, constant: 64)
        let bottomSpace = NSLayoutConstraint(item: self.bottomLbel, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLbel.superview, attribute: .BottomMargin, multiplier: 1, constant: -64)
        
        return [topCenterXConstraint, bottomCenterXConstraint, topSpace, bottomSpace]
    }
}