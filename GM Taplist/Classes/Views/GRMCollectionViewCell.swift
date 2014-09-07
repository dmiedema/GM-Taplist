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
    @IBOutlet weak var kegLevelWidthConstraint: NSLayoutConstraint!
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
    
    func setKegLevel(level: Int, animated: Bool) {
        var duration: NSTimeInterval = 0.0
        if animated { duration = 0.3 }
        kegLevelView?.superview?.layoutIfNeeded()
        
        let floatLevel = CGFloat(level)
        let newLevel: CGFloat = 320.0 * (floatLevel / 100.0)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .AllowAnimatedContent, animations: { () -> Void in
                self.kegLevelWidthConstraint?.constant = newLevel
                self.kegLevelView?.superview?.layoutIfNeeded()
            }, completion: { (complete) -> Void in })
    }
}
