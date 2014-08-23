//
//  API.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class API: AFHTTPSessionManager {
    // MARK: Properties
    private lazy var managedObjectContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()
    
    // MARK: Singleton
    class var sharedInstance: API {
    struct Singleton {
        static let instance = API.init(baseURL: NSURL(string: GrowlMovement.GMTaplist.URLs.BaseURL))
        }
        return Singleton.instance
    }
    
    // MARK: Required
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: initialize
    override init(baseURL url: NSURL!) {
        super.init(baseURL: url)
        
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFJSONRequestSerializer()
        self.requestSerializer.setValue(GrowlMovement.GMTaplist.APIKeys.APIKey, forHTTPHeaderField: GrowlMovement.GMTaplist.APIKeys.APIKeyHeader)
    }
    
/*
    // MARK: Stores/Ontap
    func beersOnTapForStore(storeID: Int, completionBlock:([OnTapBeer]) -> ()) {
        let url = NSString(format: "stores/%@/ontap", storeID)
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let beers = response["data"] as NSArray
            var onTapBeers = [OnTapBeer]()
            for beer in beers {
                onTapBeers.append(
                    OnTapBeer(beerID: beer["beer_id"] as Int,
                        tapNumber: beer["tap_number"] as Int,
                        tapLevel: beer["keg_level"] as Int))
            }
            
            completionBlock(onTapBeers)
            
        }, failure: { (dataTasK, error) -> Void in
            
        })
    }
    
    func stores(completionBlock:([Store]) -> ()) {
        self.GET("stores", parameters: nil, success: { (dataTask, response) -> Void in
            let storesData = response["data"] as NSArray
            var stores = [Store]()
            for store in storesData {
                stores.append(Store.createOrUpdate(store as NSDictionary, inManagedObjectContext: self.managedObjectContext!))
            }
            
            completionBlock(stores)
        }, failure: { (dataTask, error) -> Void in
            
        })
    }
    
    func storeDetails(storeID: Int, completionBlock:(Store) -> ()) {
        let url = NSString(format: "stores/%@", storeID)
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let storeData = response["data"] as NSDictionary
            let store = Store.createOrUpdate(storeData, inManagedObjectContext: self.managedObjectContext!)
        
            completionBlock(store)
        }, failure: { (dataTask, error) -> Void in
    
        })
    }
    
    func storeDetails(storeName: String, completionBlock:(Store) -> ()) {
        let url = NSString(format: "stores/%@", storeName)

        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let storeData = response["data"] as NSArray
            let store = Store.createOrUpdate(storeData.firstObject as NSDictionary, inManagedObjectContext: self.managedObjectContext!)
        
            completionBlock(store)
        }, failure: { (dataTask, error) -> Void in
            
        })
    }
    
    // MARK: Beers
    func beerDetails(beerID: Int, completionBlock:(Beer) -> ()) {
        let url = NSString(format: "beers/%@", beerID);
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let beerData = response["data"] as NSDictionary
            let beer = Beer.createOrUpdate(beerData, inManagedObjectContext: self.managedObjectContext!)
            
            completionBlock(beer)
        }, failure: { (dataTask, error) -> Void in
            
        })
    }

    func beers(sinceDate: NSDate?, completionBlock:([Beer]) -> ()) {
        var url = "beers/updated"
        if let date = sinceDate {
            let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                    .components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit, fromDate: date)
            url = NSString(format: "beers/updated/%@/%@/%@", components.year, components.month, components.day)
        }
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let beerData = response["data"] as NSArray
            var beers = [Beer]()
            for beer in beerData {
                beers.append(Beer.createOrUpdate(beer as NSDictionary, inManagedObjectContext: self.managedObjectContext!))
            }
            
            completionBlock(beers)
        }, failure: { (dataTask, error) -> Void in
            
        })
    }
    
    // MARK: Breweries
    func breweries(sinceDate: NSDate?, completionBlock:([Brewery]) -> ()) {
        var url = "breweries/updated"
        if let date = sinceDate {
            let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                .components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit, fromDate: date)
            url = NSString(format: "breweries/updated/%@/%@/%@", components.year, components.month, components.day)
        }
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let breweryData = response["data"] as NSArray
            var breweries = [Brewery]()
            for brewery in breweryData {
                breweries.append(Brewery.createOrUpdate(brewery as NSDictionary, inManagedObjectContext: self.managedObjectContext!))
            }
            
            completionBlock(breweries)
        }, failure: { (dataTask, error) -> Void in
            
        })
    }
    
    func breweryDetails(breweryID: Int, completionBlock:(Brewery) -> ()) {
        
    }
    
    func breweryDetails(breweryName: String, completionBlock:([Brewery]) -> ()) {
        
    }
    
    func beersForBrewery(breweryID: Int, completionBlock:(Brewery, [Beer]) -> ()) {
        
    }
    
    func beersForBrewery(breweryName: String, completionBlock:(Brewery, [Beer]) -> ()) {
    
    }
*/
}