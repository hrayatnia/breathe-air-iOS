//
//  BaseRequest.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-23.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation


protocol BaseRequest: Encodable {
    var uuid: String {get}
    var deviceId: String{get}
}
