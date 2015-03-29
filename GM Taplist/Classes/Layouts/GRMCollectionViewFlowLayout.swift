//
//  GRMCollectionViewFlowLayout.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 9/14/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMCollectionViewFlowLayout: UICollectionViewFlowLayout {
  override required init() {
    super.init()
    sharedSetup()
  }
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedSetup()
  }
  
  private func sharedSetup() {
      
  }
}