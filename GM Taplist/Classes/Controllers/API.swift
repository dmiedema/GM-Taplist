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
    private var context: NSManagedObjectContext = ANDYDataManager.sharedManager().mainContext
    
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
    
    // MARK: - Initialize
    override init(baseURL url: NSURL!) {
        super.init(baseURL: url)
        
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFJSONRequestSerializer(writingOptions: .PrettyPrinted)
        self.requestSerializer.setValue(GrowlMovement.GMTaplist.APIKeys.APIKey, forHTTPHeaderField: GrowlMovement.GMTaplist.APIKeys.APIKeyHeader)
        self.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    override init(baseURL url: NSURL!, sessionConfiguration configuration: NSURLSessionConfiguration!) {
        super.init(baseURL: url, sessionConfiguration: configuration)
        
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFJSONRequestSerializer(writingOptions: .PrettyPrinted)
        self.requestSerializer.setValue(GrowlMovement.GMTaplist.APIKeys.APIKey, forHTTPHeaderField: GrowlMovement.GMTaplist.APIKeys.APIKeyHeader)
        self.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    // MARK: - Favoriting
    func favoriteBeer(beerID: Int, completionBlock:((Bool) -> ()), failureBlock:((NSError) -> ())) {
        var userID = NSUserDefaults.standardUserDefaults().integerForKey(GrowlMovement.GMTaplist.UserDefaults.LoggedInUserID)
        let pushToken = NSUserDefaults.standardUserDefaults().stringForKey(GrowlMovement.GMTaplist.UserDefaults.PushTokenKey)

        if pushToken == nil {
            userID = 0
        }
        if userID == 0 {
            failureBlock(NSError(domain: GrowlMovement.GMTaplist.Errors.Favorite, code: -2345, userInfo: nil))
        }
        NSLog("userID : \(userID)")
        NSLog("Push token: \(pushToken)")
        let url = "favorite"
        self.POST(url, parameters: ["user_id": userID, "beer_id": beerID], success: { (dataTask, response) -> Void in
            NSLog("\(response)")
            completionBlock(true)
            
        }, failure: { (dataTask, error) -> Void in
            NSLog("\(error)")
            failureBlock(error)
        })
        
        NSLog("This is when a favorite call would happen")
    }
    func unFavoriteBeer(beerID: Int, completionBlock:((Bool) -> ()), failureBlock:((NSError) -> ())) {
        NSLog("This is when an unfavorite call would ahppen")
        var userID = NSUserDefaults.standardUserDefaults().integerForKey(GrowlMovement.GMTaplist.UserDefaults.LoggedInUserID)
        if userID == 0 {
            failureBlock(NSError(domain: GrowlMovement.GMTaplist.Errors.Unfavorite, code: -2346, userInfo: nil))
        }
        
        let url = "favorite"
        self.DELETE(url, parameters: ["user_id": userID, "beer_id": beerID], success: { (dataTask, response) -> Void in
            completionBlock(true)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }

    // MARK: - User & Settings
    func registerUserWithToken(token: String, completionBlock:((GRMUser) -> ()), failureBlock:((NSError) -> ())) {
        NSLog("Register")
        NSLog("token: \(token)")
        let url = "users"
        self.POST(url, parameters: ["user_token": token], success: { (dataTask, response) -> Void in
            NSLog("Response: \(response)")
            let rawData = response as NSDictionary
            let user = GRMUser.createOrUpdate(response["data"] as NSDictionary, inContext: self.context) as GRMUser
            NSLog("user: \(user)")
            NSUserDefaults.standardUserDefaults().setInteger(user.user_id as Int, forKey: GrowlMovement.GMTaplist.UserDefaults.LoggedInUserID)
            
            NSNotificationCenter.defaultCenter().postNotificationName(GrowlMovement.GMTaplist.Notifications.UserCreated, object: nil)
            ANDYDataManager.sharedManager().persistContext()
            completionBlock(user)
        }, failure: { (dataTask, error) -> Void in
            NSLog("Failure registering user")
            failureBlock(error)
        })
    }
    

    // MARK: - Stores/Ontap
    func beersOnTapForStore(storeID: Int, completionBlock:([BeerData]) -> (), failureBlock:((NSError)) -> ()) {
        let url = "stores/\(storeID)/ontap"
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            NSLog("Got beers")
            let rawData = response as NSDictionary
            let beers = rawData["data"] as NSArray
            var onTapBeers = [BeerData]()
            for beerDict in beers {
                let beer = GRMBeer.loadObjectID(beerDict["id"] as Int, inContext: self.context)
                if beer == nil {
                    continue
                }
                onTapBeers.append(
                    BeerData(beer: beer,
                        tapNumber: beerDict["tap_number"] as? Int,
                        tapLevel: beerDict["keg_level"] as? Int))
            }
            
            ANDYDataManager.sharedManager().persistContext()
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
                stores.append(GRMStore.createOrUpdate(store as NSDictionary, inContext: self.context))
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
            let store = GRMStore.createOrUpdate(storeData, inContext: self.context)
            
            ANDYDataManager.sharedManager().persistContext()
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
            let store = GRMStore.createOrUpdate(storeData.firstObject as NSDictionary, inContext: self.context)
        
            ANDYDataManager.sharedManager().persistContext()
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
            let beer = GRMBeer.createOrUpdate(beerData, inContext: self.context)
            
            ANDYDataManager.sharedManager().persistContext()
            completionBlock(beer)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }

    func beers(sinceDate: NSDate?, completionBlock:([GRMBeer]) -> (), failureBlock:(NSError) -> ()) {
        var url = "beers/updated"
        if let date = sinceDate {
            let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                    .components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit, fromDate: date)
            url = NSString(format: "beers/updated/%@/%@/%@", components.year, components.month, components.day)
        }

        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let beerData = rawData["data"] as NSArray
            var beers = [GRMBeer]()
            for beer in beerData {
                beers.append(GRMBeer.createOrUpdate(beer as NSDictionary, inContext: self.context))
            }
            
            ANDYDataManager.sharedManager().persistContext()
            completionBlock(beers)
        }, failure: { (dataTask, error) -> Void in
            failureBlock(error)
        })
    }
    
    // MARK: - Breweries
    func breweries(sinceDate: NSDate?, completionBlock:([GRMBrewery]) -> (), failureBlock:(NSError) -> ()) {
        var url = "breweries/updated"
        if let date = sinceDate {
            let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                .components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit, fromDate: date)
            url = NSString(format: "breweries/updated/%@/%@/%@", components.year, components.month, components.day)
        }
        
        self.GET(url, parameters: nil, success: { (dataTask, response) -> Void in
            let rawData = response as NSDictionary
            let breweryData = rawData["data"] as NSArray
            var breweries = [GRMBrewery]()
            for brewery in breweryData {
                breweries.append(GRMBrewery.createOrUpdate(brewery as NSDictionary, inContext: self.context))
            }
            
            ANDYDataManager.sharedManager().persistContext()
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

            let brewery = GRMBrewery.createOrUpdate(breweryData, inContext: self.context)

            ANDYDataManager.sharedManager().persistContext()
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
                breweries.append(GRMBrewery.createOrUpdate(brewery as NSDictionary, inContext: self.context))
            }

            ANDYDataManager.sharedManager().persistContext()
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