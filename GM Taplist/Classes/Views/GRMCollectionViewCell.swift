//
//  GRMCollectionViewCell.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/23/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

protocol GRMCollectionViewCellProtocol {
    func cellPannedAtPoint(point: CGPoint)
    func cellPanEnded()
    func favoritePressed(beerData: BeerData)
    func detailsPressed(beerData: BeerData)
}

class GRMCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    // MARK: IBOutlets
    @IBOutlet weak var cellContentsView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var topLineLabel: UILabel!
    @IBOutlet weak var middleLineLabel: UILabel!
    @IBOutlet weak var bottomLineLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var kegLevelView: UIView!
    @IBOutlet weak var kegLevelWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var favoriteViewContainer: UIView!
    @IBOutlet weak var detailsViewContainer: UIView!
    @IBOutlet weak var contentsXAlignment: NSLayoutConstraint!
    lazy var panGesture: UIPanGestureRecognizer = {
        var panGesture = UIPanGestureRecognizer(target: self, action: "cellPanned:")
        panGesture.delegate = self
        panGesture.cancelsTouchesInView = false
        return panGesture
    }()
    // MARK: Data/Delegate
    var beerData: BeerData!
    var delegate: GRMCollectionViewCellProtocol?
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addGestureRecognizer(self.panGesture)
        favoriteViewContainer.backgroundColor = GrowlMovement.GMTaplist.Colors.FavoriteMarker
        detailsViewContainer.backgroundColor = GrowlMovement.GMTaplist.Colors.NewBeerMarker
        
        favoriteViewContainer.alpha = 0
        detailsViewContainer.alpha = 0
    }
    // MARK: - Actions
    @IBAction func favoriteButtonPressed(sender: UIButton) {
        self.delegate?.favoritePressed(beerData)
    }
    @IBAction func detailsButtonPressed(sender: UIButton) {
        self.delegate?.detailsPressed(beerData)
    }
    
    func cellPanned(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translationInView(self)
        let velocity = panGesture.velocityInView(self)
        
        switch panGesture.state {
        case .Began:
            NSLog("Pan Began")
        case .Changed:
            if fabs(translation.x) > 50 {
                delegate?.cellPannedAtPoint(panGesture.locationInView(self.superview))
                handleValidPan(translation.x)
            }
        case .Ended, .Cancelled, .Failed:
            contentView.layoutIfNeeded()
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.contentsXAlignment.constant = 0
                self.detailsViewContainer.alpha = 0
                self.favoriteViewContainer.alpha = 0
                self.contentView.layoutIfNeeded()
            })
            delegate?.cellPanEnded()
            NSLog("Pan Ended, Cancelled or Failed")
        case .Possible:
            NSLog("Pan Possible")
        }
    }
    
    func handleValidPan(translation: CGFloat) {
        let alpha = (fabs(translation) - 75) / 100
        
        if translation > 0 { // favorite
            favoriteViewContainer.alpha = alpha
            self.contentsXAlignment.constant = max(-((translation - 50) / 2), -100)
        } else { // details
            detailsViewContainer.alpha = alpha
            self.contentsXAlignment.constant = min(-((translation + 50) / 2), 100)
        }
        if fabs(translation) > 175 {
            // trigger action
            if translation > 0 {
                NSLog("Favorite")
                delegate?.favoritePressed(beerData)
            } else {
                NSLog("Details")
                delegate?.detailsPressed(beerData)
            }
        }
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
        
        if level < 20 {
            kegLevelView.backgroundColor = GrowlMovement.GMTaplist.Colors.RedStatus
        } else if level < 40 {
            kegLevelView.backgroundColor = GrowlMovement.GMTaplist.Colors.YellowStatus
        } else {
            kegLevelView.backgroundColor = GrowlMovement.GMTaplist.Colors.GreenStatus
        }
        
        let floatLevel = CGFloat(level)
        let newLevel: CGFloat = 320.0 * (floatLevel / 100.0)
        
        UIView.animateWithDuration(duration, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .AllowAnimatedContent, animations: { () -> Void in
                self.kegLevelWidthConstraint?.constant = newLevel
                self.kegLevelView?.superview?.layoutIfNeeded()
            }, completion: { (complete) -> Void in })
    }
    
    // MARK: - UIGestureRecognizer Delegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
