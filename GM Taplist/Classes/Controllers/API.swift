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
    // MARK: - Properties
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()
    
    // MARK: - Singleton
    class var sharedInstance: API {
    struct Singleton {
        static let instance = API.init(baseURL: NSURL(string: GrowlMovement.GMTaplist.URLs.BaseURL))
        }
        return Singleton.instance
    }
    
    // MARK: - Required
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - 
    private func getPrivateContext() -> NSManagedObjectContext {
        var context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.managedObjectContext.persistentStoreCoordinator

        return context
    }
    
    private func mergeContext(context: NSManagedObjectContext, withContext: NSManagedObjectContext) -> Bool {
        return true
    }
    
    // MARK: - Initialize
    override init(baseURL url: NSURL!) {
        super.init(baseURL: url)
        
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFJSONRequestSerializer()
        self.requestSerializer.setValue(GrowlMovement.GMTaplist.APIKeys.APIKey, forHTTPHeaderField: GrowlMovement.GMTaplist.APIKeys.APIKeyHeader)
        self.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    override init(baseURL url: NSURL!, sessionConfiguration configuration: NSURLSessionConfiguration!) {
        super.init(baseURL: url, sessionConfiguration: configuration)
        
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFJSONRequestSerializer()
        self.requestSerializer.setValue(GrowlMovement.GMTaplist.APIKeys.APIKey, forHTTPHeaderField: GrowlMovement.GMTaplist.APIKeys.APIKeyHeader)
        self.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    // MARK: - Favoriting
    func favoriteBeer(beerID: Int, completionBlock:((Bool) -> ()), failureBlock:((NSError) -> ())) {
    }
    func unFavoriteBeer(beerID: Int, completionBlock:((Bool) -> ()), failureBlock:((NSError) -> ())) {
    }

    // MARK: - User & Settings

    // MARK: - Stores/Ontap
    func beersOnTapForStore(storeID: Int, completionBlock:([BeerData]) -> (), failureBlock:((NSError)) -> ()) {
        let url = "stores/\(storeID)/ontap"
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            NSLog("Got beers")
            let rawData = response as NSDictionary
            let beers = rawData["data"] as NSArray
            var onTapBeers = [BeerData]()
            for beerDict in beers {
                let beer = GRMBeer.loadObjectID(beerDict["id"] as Int, inManagedObjectContext: self.managedObjectContext)
                if beer == nil {
                    continue
                }
                onTapBeers.append(
                    BeerData(beer: beer,
                        tapNumber: beerDict["tap_number"] as? Int,
                        tapLevel: beerDict["keg_level"] as? Int))
            }
            
            completionBlock(onTapBeers)
        }, failure: { (dataTasK, error) -> Void in
            NSLog("Failed to get beers\n\(error)")
            failureBlock(error)
        })
    }
    
    func stores(completionBlock:([GRMStore]) -> (), failureBlock:(NSError) -> ()) {
        self.GET("stores", parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let storesData = rawData["data"] as NSArray
            var stores = [GRMStore]()
            for store in storesData {
                stores.append(GRMStore.createOrUpdate(store as NSDictionary, inManagedObjectContext: self.managedObjectContext))
            }
            
            completionBlock(stores)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    func storeDetails(storeID: Int, completionBlock:(GRMStore) -> (), failureBlock:(NSError) -> ()) {
        let url = "stores/\(storeID)"
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let storeData = rawData["data"] as NSDictionary
            let store = GRMStore.createOrUpdate(storeData, inManagedObjectContext: self.managedObjectContext)
        
            completionBlock(store)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    func storeDetailsName(storeName: String, completionBlock:(GRMStore) -> (), failureBlock:(NSError) -> ()) {
        let url = "stores/\(storeName)"

        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let storeData = rawData["data"] as NSArray
            let store = GRMStore.createOrUpdate(storeData.firstObject as NSDictionary, inManagedObjectContext: self.managedObjectContext)
        
            completionBlock(store)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    // MARK: - Beers
    func beerDetails(beerID: Int, completionBlock:(GRMBeer) -> (), failureBlock:(NSError) -> ()) {
        let url = "beers/\(beerID)"
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let beerData = rawData["data"] as NSDictionary
            let beer = GRMBeer.createOrUpdate(beerData, inManagedObjectContext: self.managedObjectContext)
            
            completionBlock(beer)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }

    func beers(sinceDate: NSDate?, completionBlock:([GRMBeer]) -> (), failureBlock:(NSError) -> ()) {
        var url = "beers/updated"
        if let date = sinceDate {
            let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                    .components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit, fromDate: date)
            url = NSString(format: "beers/updated/%@/%@/%@", components.year, components.month, components.day)
        }

        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let beerData = rawData["data"] as NSArray
            var beers = [GRMBeer]()
            for beer in beerData {
                beers.append(GRMBeer.createOrUpdate(beer as NSDictionary, inManagedObjectContext: self.managedObjectContext))
            }
            
            completionBlock(beers)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    // MARK: - Breweries
    func breweries(sinceDate: NSDate?, completionBlock:([GRMBrewery]) -> (), failureBlock:(NSError) -> ()) {
        var url = "breweries/updated"
        if let date = sinceDate {
            let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                .components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit, fromDate: date)
            url = NSString(format: "breweries/updated/%@/%@/%@", components.year, components.month, components.day)
        }
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let breweryData = rawData["data"] as NSArray
            var breweries = [GRMBrewery]()
            for brewery in breweryData {
                breweries.append(GRMBrewery.createOrUpdate(brewery as NSDictionary, inManagedObjectContext: self.managedObjectContext))
            }
            
            completionBlock(breweries)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    func breweryDetails(breweryID: Int, completionBlock:(GRMBrewery) -> (), failureBlock:(NSError) -> ()) {
        var url = "breweries/\(breweryID)"

        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let breweryData = rawData["data"] as NSDictionary

            let brewery = GRMBrewery.createOrUpdate(breweryData, inManagedObjectContext: self.managedObjectContext)

            completionBlock(brewery)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    func breweryDetailsName(breweryName: String, completionBlock:([GRMBrewery]) -> (), failureBlock:(NSError) -> ()) {
        var url = "breweries/\(breweryName)"

        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            var breweries = [GRMBrewery]()
            let breweryData = rawData["data"] as NSArray
            
            for brewery in breweryData {
                breweries.append(GRMBrewery.createOrUpdate(brewery as NSDictionary, inManagedObjectContext: self.managedObjectContext))
            }

            completionBlock(breweries)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    func beersForBrewery(breweryID: Int, completionBlock:(GRMBrewery, [GRMBeer]) -> (), failureBlock:(NSError) -> ()) {
        
    }
    
    func beersForBreweryName(breweryName: String, completionBlock:(GRMBrewery, [GRMBeer]) -> (), failureBlock:(NSError) -> ()) {
    
    }

}