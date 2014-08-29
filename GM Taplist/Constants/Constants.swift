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
    func itemAtIndexPath(indexPath: NSIndexPath) -> Beer
}

struct GrowlMovement {
    struct GMTaplist {
        struct UserDefaults {
            static let LoggedInUserID  = "com.GrowlMovement.GMTaplist.LoggedInUserID"
            static let PreferredStores = "com.GrowlMovement.GMTaplist.PreferredStores"
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
            static let BaseURL    = "http://api.growlmovement.com/v0"
        }
        struct APIKeys {
            static let ResetBadgeNotification = "reset-notification-count"
            static let PreferredStores        = "preferred-stores"
            static let APIKey                 = "4ad31c634bd46b50bb7a1c97b970952f"
            static let APIKeyHeader           = "X-GrowlMovement-API-Key"
        }
        struct Colors {
            static let NewBeerMarker  = UIColor(red: 5, green: 5, blue: 5, alpha: 1.0)
            static let GreenStatus    = UIColor(red: 0, green: 5, blue: 5, alpha: 1.0)
            static let YellowStatus   = UIColor(red: 5, green: 5, blue: 0, alpha: 1.0)
            static let RedStatus      = UIColor(red: 5, green: 0, blue: 0, alpha: 1.0)
            static let FavoriteMarker = UIColor(red: 5, green: 5, blue: 0, alpha: 1.0)
        }
        struct CollectionView {
            static let CellReuseIdentifier          = "GMTaplist.CellReuseIdentifier"
            static let OnTapCellReuseIdentifier     = "GMTaplist.OnTapCellReuseIdentifier"
            static let AllBeersCellReuseIdentifier  = "GMTaplist.AllBeersCellReuseIdentifier"
            static let FavoritesCellReuseIdentifier = "GMTaplist.FavoritesCellReuseIdentifier"
            static let HeaderReuseIdentifier        = "GMTaplist.HeaderReuseIdentifier"
            static let FooterReuseIdentifier        = "GMTaplist.FooterReuseIdentifier"
        }
    }
}
