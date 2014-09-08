//
//  GRMCollectionViewDataSource.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/24/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class BeerData {
    var beer: GRMBeer
    var tapNumber: Int?
    var tapLevel: Int?

    required init(beer: GRMBeer, tapNumber: Int?, tapLevel: Int?) {
        self.beer = beer
        self.tapNumber = tapNumber
        self.tapLevel = tapLevel
    }
    
    func onTapDisplayString() -> String {
        return "\(tapNumber!). \(beer.name)"
    }
    
    func allBeersDisplayString() -> String {
        return "\(beer.name)"
    }
    
    func attributedStringForBreweryInformation() -> NSAttributedString {
        var attributedString: NSMutableAttributedString
        let brewery = beer.brewery
        
        if brewery.city.isEmpty || brewery.state.isEmpty {
            attributedString = NSMutableAttributedString(string: brewery.name)
        } else {
            
            attributedString = NSMutableAttributedString(string: NSString(format: "%@ - ", brewery.name))
            
            var fontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleSubheadline)
            fontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(.TraitItalic)
            
            let attributedCityState = NSAttributedString(string: "\(brewery.city) \(brewery.state)", attributes: [NSFontAttributeName: UIFont(descriptor: fontDescriptor, size: 0.0)])
            
            attributedString.appendAttributedString(attributedCityState)
        }
        
        return attributedString
    }
    
    func onTapBottomLineString() -> String {
        return "IBU: \(beer.ibu)  ABV: \(beer.abv)  Growler: \(beer.growler_price)  Growlette: \(beer.growlette_price)"
    }
    
    func allBeersBottomLineString() -> String {
        return "IBU: \(beer.ibu)  ABV: \(beer.abv)  Style: \(beer.style.style)"
    }
}

protocol GRMCollectionViewDataSourceDelegate {
    var selectedItemIndexPath: NSIndexPath? {get}
    func dataLoading() -> ()
    func dataLoaded() -> ()
    func dataFailedToLoad(error: NSError) -> ()
}

protocol GRMCollectionViewDataSourceProtocol {
    func itemForIndexPath(indexPath: NSIndexPath) -> BeerData
}

class GRMCollectionViewDataSource: NSObject {

    let cellIdentifier: String
    let cellConfigurationBlock: (cell: GRMCollectionViewCell, data: BeerData) -> ()
    var delegate: GRMCollectionViewDataSourceDelegate?

    internal lazy var managedObjectContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()

    required init(cellIdentifier: String, configurationBlock: (GRMCollectionViewCell, BeerData) ->()) {
        self.cellIdentifier = cellIdentifier
        self.cellConfigurationBlock = configurationBlock
        super.init()
    }
}