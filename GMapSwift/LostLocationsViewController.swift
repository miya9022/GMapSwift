//
//  LostLocationsViewController.swift
//  GMapSwift
//
//  Created by app on 8/23/16.
//  Copyright © 2016 app. All rights reserved.
//

import UIKit

protocol MyCellProtocol {
    func didTapCell(cell: LostLocationsTableViewCell, indexOfCell : Int?)
}

class LostLocationsViewController: UITableViewController, MyCellProtocol, SWRevealViewControllerDelegate {

    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cellDelegate = self;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sw_front" {
            let navigationViewController = self.revealViewController().frontViewController as! UINavigationController
            let mapViewController = navigationViewController.visibleViewController as! ViewController
            if let selectedLocationCell = sender as? LostLocationsTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedLocationCell)
                let selectedLocation = locations[indexPath!.row]
                mapViewController.indicateLocation = selectedLocation
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LostLocationsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LostLocationsTableViewCell
        
        // Configure the cell...
        let location = locations[indexPath.row]
        cell.locNameLabel.text = location.loc_name
        cell.locRealAddressLabel.text = location.loc_real_address
        cell.locCoordinateXLabel.text = location.latitude.description
        cell.locCoordinateYLabel.text = location.longitude.description
        return cell
    }
    
    var cellDelegate: MyCellProtocol?
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("LostLocationsTableViewCell", forIndexPath: indexPath) as! LostLocationsTableViewCell
        self.cellDelegate?.didTapCell(cell, indexOfCell: indexPath.row)
    }

    func didTapCell(cell: LostLocationsTableViewCell, indexOfCell: Int?) {
        self.revealViewController().revealToggleAnimated(false)
        cell.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        if let navigationViewController = self.revealViewController().frontViewController as? UINavigationController {
            let mainViewController = navigationViewController.topViewController as? ViewController
            let selectedLocation = locations[indexOfCell!]
            mainViewController?.indicateLocation = selectedLocation
            mainViewController?.loadInidicatedView()
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}