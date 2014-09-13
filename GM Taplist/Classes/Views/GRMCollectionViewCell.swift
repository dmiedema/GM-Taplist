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
        NSLog("Translation = \(translation)")
        let velocity = panGesture.velocityInView(self)
        NSLog("velocity = \(velocity)")
        
        switch panGesture.state {
        case .Began:
            NSLog("Pan Began")
        case .Cancelled:
            NSLog("Pan Cancelled")
        case .Changed:
            NSLog("Pan Changed")
            if fabs(translation.x) > 50 {
                NSLog("Show some pull")
            }
        case .Ended:
            NSLog("Pan Ended")
        case .Failed:
            NSLog("Pan Failed")
        case .Possible:
            NSLog("Pan Possible")
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
            kegLevelView.backgroundColor = UIColor(red: 208.0/255.0, green: 2.0/255.0, blue: 27.0/255.0, alpha: 0.3)
        } else if level < 40 {
            kegLevelView.backgroundColor = UIColor(red: 236.0/255.0, green: 218.0/255.0, blue: 62.0/255.0, alpha: 0.3)
        } else {
            kegLevelView.backgroundColor = UIColor(red: 126.0/255.0, green: 211.0/255.0, blue: 33.0/255.0, alpha: 0.3)
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
