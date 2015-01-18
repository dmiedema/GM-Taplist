//
//  GRMSettingsTableViewController.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/23/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class GRMSettingsTableViewController: UITableViewController {
    // MARK: - Properties
    // MARK: Private
    let GRMSettingsSectionAbout         = 0
    let GRMSettingsSectionNotifications = 1
    let GRMSettingsSectionSupport       = 2
    let GRMSettingsSectionOther         = 3
    
    private lazy var context: NSManagedObjectContext = {
        ANDYDataManager.sharedManager().mainContext
    }()
    
    private let aboutContent = [
        NSLocalizedString("Section.About[0]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "About Growl Movement", comment: "About Growl Movement"),
        NSLocalizedString("Section.About[1]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Operating Hours", comment: "Operating Hours"),
        NSLocalizedString("Section.About[2]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Take me!", comment: "Take me!"),
        NSLocalizedString("Section.About[3]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Help!", comment: "Help!"),
        NSLocalizedString("Section.About[4]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "About the app", comment: "About the app"),
    ]
    private let notificationContent = [
        NSLocalizedString("Section.Notifications[0]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Preferred Stores", comment: "Preferred Stores"),
        NSLocalizedString("Section.Notifications[1]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Test Push Notifications", comment: "Test Push Notifications"),
    ]
    private let supportContent = [
        NSLocalizedString("Section.Support[0]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "I have an idea", comment: "I have an idea"),
        NSLocalizedString("Section.Support[1]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Something went wrong", comment: "Something went wrong"),
    ]
    private let otherContent = [
        NSLocalizedString("Section.Other[0]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Show Store Name", comment: "Show Store Name"),
        NSLocalizedString("Section.Other[1]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Force data synchronization", comment: "Force data synchronization"),
        NSLocalizedString("Section.Other[2]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Cleanup Favorites Duplicates", comment: "Cleanup Favorites Duplicates"),
        NSLocalizedString("Section.Other[3]", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Review the App", comment: "Review the App"),
    ]
    
    private let sectionTitles = [
        NSLocalizedString("Section.About", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "About", comment: "About"),
        NSLocalizedString("Section.Notifications", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Notifications", comment: "Notifications"),
        NSLocalizedString("Section.Support", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Support", comment: "Support"),
        NSLocalizedString("Section.Other", tableName: "GRMSettingsTableViewController", bundle: NSBundle.mainBundle(), value: "Other", comment: "Other"),
    ]
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if section == GRMSettingsSectionAbout {
            count = aboutContent.count
        } else if section == GRMSettingsSectionNotifications {
            count = notificationContent.count
        } else if section == GRMSettingsSectionSupport {
            count = supportContent.count
        } else if section == GRMSettingsSectionOther {
            count = otherContent.count
        }
        
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(GrowlMovement.GMTaplist.TableView.CellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let content = contentForIndexPath(indexPath)
        cell.textLabel?.text = content.0
        cell.detailTextLabel?.text = content.1
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: Private Methods
    private func contentForIndexPath(indexPath: NSIndexPath) -> (String, String) {
        var text = ""
        var rightText = ""
        switch indexPath.section {
        case GRMSettingsSectionAbout:
            text = aboutContent[indexPath.row]
        case GRMSettingsSectionNotifications:
            text = notificationContent[indexPath.row]
            if indexPath.row == 0 {
                rightText = "\(GRMStore.preferredStoresInContext(context).count)"
            }
        case GRMSettingsSectionSupport:
            text = supportContent[indexPath.row]
        case GRMSettingsSectionOther:
            text = otherContent[indexPath.row]
        default: break;
        }
        
        return (text, rightText)
    }
    
}