//
//  GRMEmptyView.swift
//  GM Taplist
//
//  Created by Daniel on 1/17/15.
//  Copyright (c) 2015 Growl Movement. All rights reserved.
//

import Foundation

class GRMEmptyView: UIView {
    
    // MARK: - Properties
    
    // MARK: Outlets
    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Init
    
    required convenience init(frame: CGRect, image: UIImage, message: String) {
        self.init(frame: frame)
        
        self.imageView.image = image
        self.label.text = message
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("GRMEmptyView", owner: self, options: nil)
        view.frame = frame
        self.addSubview(view)
    }

    required init(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
}