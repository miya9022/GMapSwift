//
//  MenuViewController.swift
//  GMapSwift
//
//  Created by app on 8/21/16.
//  Copyright © 2016 app. All rights reserved.
//

import UIKit

class MenuViewController : UITableViewController {
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleLostLocations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show_lost_locations" {
            let lostLocationsTableViewController = segue.destinationViewController as! LostLocationsViewController
            lostLocationsTableViewController.locations = locations
        }
    }
    
    func loadSampleLostLocations() {
        let location1 = Location(loc_name: "location1", latitude: Double(40.711261), longitude: Double(-73.997595), loc_real_address: "location1")
        let location2 = Location(loc_name: "location2", latitude: Double(40.712241), longitude: Double(-73.999240), loc_real_address: "location2")
        let location3 = Location(loc_name: "location3", latitude: Double(40.714228), longitude: Double(-73.994926), loc_real_address: "location3")
        let location4 = Location(loc_name: "location4", latitude: Double(40.717589), longitude: Double(-73.999315), loc_real_address: "location4")
        let location5 = Location(loc_name: "location5", latitude: Double(40.718179), longitude: Double(-74.014979), loc_real_address: "location5")
        
        locations.append(location1!)
        locations.append(location2!)
        locations.append(location3!)
        locations.append(location4!)
        locations.append(location5!)
    }
    
}
