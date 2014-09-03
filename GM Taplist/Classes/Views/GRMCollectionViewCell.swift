//
//  GRMCollectionViewCell.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/23/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

protocol GRMCollectionViewCellProtocol {
    func favoritePressed(beerData: BeerData)
    func detailsPressed(beerData: BeerData)
}

class GRMCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    // MARK: IBOutlets
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var topLineLabel: UILabel!
    @IBOutlet weak var middleLineLabel: UILabel!
    @IBOutlet weak var bottomLineLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var kegLevelView: UIView!
    // MARK: Data/Delegate
    var beerData: BeerData!
    var delegate: GRMCollectionViewCellProtocol?
    
    // MARK: - Actions
    @IBAction func favoriteButtonPressed(sender: UIButton) {
        self.delegate?.favoritePressed(beerData)
    }
    @IBAction func detailsButtonPressed(sender: UIButton) {
        self.delegate?.detailsPressed(beerData)
    }
    
    // MARK: - Setters
    func setBeerData(beerData: BeerData) {
        self.beerData = beerData
        let favorite = self.beerData.beer.favorite.boolValue
        self.setFavorite(favorite, animated: false)
        
        if self.beerData.beer.brewery.city.isEmpty || self.beerData.beer.brewery.state.isEmpty {
            middleLineLabel.text = self.beerData.beer.brewery.name
        } else {
            let brewery = self.beerData.beer.brewery
            var attributedString = NSMutableAttributedString(string: NSString(format: "%@ - ", brewery.name))
            
            var fontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleSubheadline)
            fontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(.TraitItalic)
            
            let attributedCityState = NSAttributedString(string: "\(brewery.city) \(brewery.state)", attributes: [NSFontAttributeName: UIFont(descriptor: fontDescriptor, size: 0.0)])
            
            attributedString.appendAttributedString(attributedCityState)
            middleLineLabel.attributedText = attributedString
        }
        
    }
    
    func setFavorite(favorite: Bool, animated: Bool) {
        var alpha: CGFloat = 0.0
        if favorite { alpha = 1.0 }
        
        var duration: NSTimeInterval = 0.0
        if animated { duration = 0.3 }
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.favoriteImageView.alpha = alpha
        })
    }
}