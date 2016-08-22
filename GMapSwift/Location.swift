//
//  Location.swift
//  MapCC
//
//  Created by app on 8/22/16.
//  Copyright © 2016 app. All rights reserved.
//

import UIKit

class Location: NSObject, NSCoding {
    var loc_name: String
    var latitude: Double
    var longitude: Double
    var loc_real_address: String?
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("locations")
    
    struct PropertyKey {
        static let locNameKey = "loc_name"
        static let latitudeKey = "latitude"
        static let longitudeKey = "longitude"
        static let locRealAddressKey = "loc_real_address"
    }
    
    init?(loc_name: String, latitude: Double, longitude: Double, loc_real_address: String?) {
        self.loc_name = loc_name
        self.latitude = latitude
        self.longitude = longitude
        self.loc_real_address = loc_real_address
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(loc_name, forKey: PropertyKey.locNameKey)
        aCoder.encodeObject(latitude, forKey: PropertyKey.latitudeKey)
        aCoder.encodeObject(longitude, forKey: PropertyKey.longitudeKey)
        aCoder.encodeObject(loc_real_address, forKey: PropertyKey.locRealAddressKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let loc_name = aDecoder.decodeObjectForKey(PropertyKey.locNameKey) as! String
        let latitude = aDecoder.decodeObjectForKey(PropertyKey.latitudeKey) as! Double
        let longitude = aDecoder.decodeObjectForKey(PropertyKey.longitudeKey) as! Double
        let loc_real_address = aDecoder.decodeObjectForKey(PropertyKey.locRealAddressKey) as? String
        self.init(loc_name: loc_name, latitude: latitude, longitude: longitude, loc_real_address: loc_real_address)
    }
}