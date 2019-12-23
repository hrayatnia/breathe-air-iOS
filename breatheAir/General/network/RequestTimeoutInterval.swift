//
//  RequestTimeoutInterval.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation

enum RequestTimeoutInterval: Double {
    case long        = 30.0
    case `default`    = 15.0
    case fast        = 5.0
}

let networkQueue = DispatchQueue(label: "ir.daal.iosapp", qos: .utility, attributes: [.concurrent])
