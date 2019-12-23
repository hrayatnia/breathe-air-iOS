//
//  Location.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-23.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation


struct Location:BaseRequest, Encodable {
    var uuid: String
    var deviceId: String
    let lat: Double
    let long: Double
    let date: Date
}
