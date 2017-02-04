//
//  Places.swift
//  goPlaces
//
//  Created by abhilash uday on 12/10/16.
//  Copyright © 2016 AbhilashSU. All rights reserved.
//

import Foundation

class Places {
    var name: String
    var address: String
    var website:String
    var longitude: String
    var latitude: String

    init(name: String,address: String, website: String, longitude: String,latitude: String) {
        self.name = name
        self.longitude = longitude
        self.address = address
        self.website =  website
        self.latitude =  latitude
    }
    
}
