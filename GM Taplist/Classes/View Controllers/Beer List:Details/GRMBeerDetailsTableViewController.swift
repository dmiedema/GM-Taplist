//
//  GRMBeerDetailsTableViewController.swift
//  GM Taplist
//
//  Created by Daniel on 9/3/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMBeerDetailsTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

  var beerData: BeerData!
  var managedObjectContext: NSManagedObjectContext!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
      
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
  }
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
  }
  
  // MARK: - Table View Delegate
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
  }
  
  // MARK: - Table View Datasource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // WARN: Incomplete
    return 0
  }
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier(GrowlMovement.GMTaplist.TableView.CellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
  }
}