//
//  Constants.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import UIKit

protocol GMTaplistCollectionViewDataSource: UICollectionViewDataSource {
  func itemAtIndexPath(indexPath: NSIndexPath) -> GRMBeer
}

struct GrowlMovement {
  struct CoreData {
    var Context: DATAStack {
      return DATAStack(modelName: "GM_Taplist", bundle: NSBundle.mainBundle(), storeType: .SQLiteStoreType)
    }
  }
  struct GMTaplist {
    struct UserDefaults {
      static let DefaultAppGroupSuiteName = "group.com.growlmovement.gmtaplist.defaultgroup"
      static let LoggedInUserID           = "com.GrowlMovement.GMTaplist.LoggedInUserID"
      static let PreferredStores          = "com.GrowlMovement.GMTaplist.PreferredStores"
      static let PushTokenKey             = "com.GrowlMovement.GMTaplist.PushTokenKey"
      static let LastViewedStore          = "com.GrowlMovement.GMTaplist.LastViewedStore"
      static let LastRetreivedBeerDate    = "com.GrowlMovement.GMTaplist.LastRetreivedBeerDate"
      static let LastRetreivedBreweryDate = "com.GrowlMovement.GMTaplist.LastRetreivedBreweryDate"
      static let LastRetreivedStyleDate   = "com.GrowlMovement.GMTaplist.LastRetreivedStyleDate"
      static let LastRetreivedUserDate    = "com.GrowlMovement.GMTaplist.LastRetreivedUserDate"
    }
    struct Notifications {
      static let UserCreated = "com.GrowlMovement.GMTaplist.Notifications.UserCreated"
    }
    struct Errors {
      struct Network {
        static let Generic    = "com.GrowlMovement.GMTaplist.Error.Network.Generic"
        static let Favorite   = "com.GrowlMovement.GMTaplist.Error.Network.Favorite"
        static let Unfavorite = "com.GrowlMovement.GMTaplist.Error.Network.Unfavorite"
      }
      struct CoreData {
        static let Generic    = "com.GrowlMovement.GMTaplist.Error.CoreData.Generic"
        static let Favorite   = "com.GrowlMovement.GMTaplist.Error.CoreData.Favorite"
        static let Unfavorite = "com.GrowlMovement.GMTaplist.Error.CoreData.Unfavorite"
      }
      static let Generic    = "com.GrowlMovement.GMTaplist.Error.Generic"
      static let Favorite   = "com.GrowlMovement.GMTaplist.Error.Favorite"
      static let Unfavorite = "com.GrowlMovement.GMTaplist.Error.Unfavorite"
    }
    struct CoreData {
      struct ObjectEntityNames {
        static let Beer    = "Beer"
        static let Brewery = "Brewery"
        static let Device  = "Device"
        static let Review  = "Review"
        static let Store   = "Store"
        static let Style   = "Style"
        static let User    = "User"
      }
    }
    struct Success {
      static let Generic    = "com.GrowlMovement.GMTaplist.Success.Generic"
      static let Favorite   = "com.GrowlMovement.GMTaplist.Success.Favorite"
      static let Unfavorite = "com.GrowlMovement.GMTaplist.Success.Unfavorite"
    }
    struct Data {
      static let Generic    = "com.GrowlMovement.GMTaplist.Data.Generic"
      static let Favorite   = "com.GrowlMovement.GMTaplist.Data.Favorite"
      static let Unfavorite = "com.GrowlMovement.GMTaplist.Data.Unfavorite"
    }
    struct URLs {
      static let OldBaseURL = "http://www.growlmovement.com/_app/GrowlersAppPage.php"
      static let BaseURL    = "http://api.growlmovement.com/v0/"
    }
    struct APIKeys {
      static let ResetBadgeNotification = "reset-notification-count"
      static let PreferredStores        = "preferred-stores"
      static let APIKey                 = "7e07093c366f0a13267c6dbd9409e44e"
      static let APIKeyHeader           = "X-GrowlMovement-API-Key"
    }
    struct Colors {
      static let NewBeerMarker  = UIColor(red: 1, green: 0, blue: 1, alpha: 1.0)
      static let GreenStatus    = UIColor(red: 126.0/255.0, green: 211.0/255.0, blue: 33.0/255.0, alpha: 0.3)
      static let YellowStatus   = UIColor(red: 236.0/255.0, green: 218.0/255.0, blue: 62.0/255.0, alpha: 0.3)
      static let RedStatus      = UIColor(red: 208.0/255.0, green: 2.0/255.0, blue: 27.0/255.0, alpha: 0.3)
      static let FavoriteMarker = UIColor(red: 0.6, green: 1, blue: 0.2, alpha: 1.0)
    }
    struct CollectionView {
      static let StorybardIdentifier          = "GRMCollectionViewController"
      static let CellReuseIdentifier          = "GMTaplist.CollectionView.CellReuseIdentifier"
      static let OnTapCellReuseIdentifier     = "GMTaplist.CollectionView.OnTapCellReuseIdentifier"
      static let AllBeersCellReuseIdentifier  = "GMTaplist.CollectionView.AllBeersCellReuseIdentifier"
      static let FavoritesCellReuseIdentifier = "GMTaplist.CollectionView.FavoritesCellReuseIdentifier"
      static let HeaderReuseIdentifier        = "GMTaplist.CollectionView.HeaderReuseIdentifier"
      static let FooterReuseIdentifier        = "GMTaplist.CollectionView.FooterReuseIdentifier"
    }
    struct TableView {
      static let StoryboardIdentifier               = "GRMBeerDetailsTableViewController"
      static let CellReuseIdentifier                = "GMTaplist.TableView.CellReuseIdentifier"
      static let HeaderReuseIdentifier              = "GMTaplist.TableView.HeaderReuseIdentifier"
      static let DetailsCellIdentifier              = "GMTaplist.TableView.DetailsCellIdentifier"
      static let PurchasedAndFavoriteCellIdentifier = "GMTaplist.TableView.PurchasedAndFavoriteCellIdentifier"
    }
  }
}
