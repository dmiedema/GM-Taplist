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
            
            attributedString = NSMutableAttributedString(string: NSString(format: "%@ - ", brewery.name) as! String)
            
            var fontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleSubheadline)
            fontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(.TraitItalic)!
            
            let attributedCityState = NSAttributedString(string: "\(brewery.city) \(brewery.state)", attributes: [NSFontAttributeName: UIFont(descriptor: fontDescriptor, size: 0.0)])
            
            attributedString.appendAttributedString(attributedCityState)
        }
        
        return attributedString
    }
    
    func onTapBottomLineString() -> String {
        return "IBU: \(beer.ibu)  ABV: \(beer.abv)  Growler: \(beer.growler_price)  Growlette: \(beer.growlette_price)"
    }
    
    func allBeersBottomLineString() -> String {
        let styleTitle = NSLocalizedString("Style", tableName: "GRMCollectionViewDataSource", bundle: NSBundle.mainBundle(), value: "Style", comment: "Syle")
        if let style = beer.style.style {
            return "IBU: \(beer.ibu)  ABV: \(beer.abv)  \(styleTitle): \(style)"
        }
        let unknown = NSLocalizedString("Unknown", tableName: "GRMCollectionViewDataSource", bundle: NSBundle.mainBundle(), value: "Unknown", comment: "Unknown")
        return "IBU: \(beer.ibu)  ABV: \(beer.abv)  \(styleTitle): \(unknown)"
    }
    
    // MARK: Height Measurements
    func cellHeight(cellWidth: CGFloat, onTap: Bool) -> CGFloat {
        return cellHeightForData(cellWidth, onTap: onTap, padding: 24)
    }
    
    func cellHeightForData(width: CGFloat, onTap: Bool, padding: CGFloat) -> CGFloat {
        let height: CGFloat =
            heightForLabel((onTap) ? self.onTapDisplayString() : self.allBeersDisplayString(), preferredFontStyle: UIFontTextStyleHeadline, width: width) +
            heightForAttributedString(self.attributedStringForBreweryInformation(), preferredFontStyle: UIFontTextStyleSubheadline, width: width) +
            heightForLabel((onTap) ? self.onTapBottomLineString() : self.allBeersBottomLineString(), preferredFontStyle: UIFontTextStyleFootnote, width: width) + padding
        
        return height
    }
    
    private func heightForLabel(text: String, preferredFontStyle: String, width: CGFloat) -> CGFloat {
        let font = UIFont.preferredFontForTextStyle(preferredFontStyle)
        let attributedText = NSAttributedString(string: text, attributes: [NSFontAttributeName: font])
        
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.attributedText = attributedText
        
        let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.max))
        
        return size.height
    }
    
    private func heightForAttributedString(text: NSAttributedString, preferredFontStyle: String, width: CGFloat) -> CGFloat {
        let font = UIFont.preferredFontForTextStyle(preferredFontStyle)
        
        var attributedText = text.mutableCopy() as! NSMutableAttributedString
        attributedText.addAttributes([NSFontAttributeName: font], range: NSMakeRange(0, text.length))
        
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.attributedText = attributedText
        
        let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.max))
        
        return size.height
    }
}

protocol GRMCollectionViewDataSourceDelegate {
    var selectedItemIndexPath: NSIndexPath? {get}
    func dataLoading() -> ()
    func dataLoaded() -> ()
    func dataFailedToLoad(error: NSError) -> ()
}

protocol GRMCollectionViewDataSourceProtocol: NSObjectProtocol {
    func itemForIndexPath(indexPath: NSIndexPath) -> BeerData
}

class GRMCollectionViewDataSource: NSObject {

    let cellIdentifier: String
    let cellConfigurationBlock: (cell: GRMCollectionViewCell, data: BeerData) -> ()
    var delegate: GRMCollectionViewDataSourceDelegate?

    let context: NSManagedObjectContext = GrowlMovement.CoreData().Context.mainContext

    required init(cellIdentifier: String, configurationBlock: (GRMCollectionViewCell, BeerData) ->()) {
        self.cellIdentifier = cellIdentifier
        self.cellConfigurationBlock = configurationBlock
        super.init()
    }
}