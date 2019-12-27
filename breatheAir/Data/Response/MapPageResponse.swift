//
//  MapPageResponse.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift

struct MapPageResponse: BaseResponse {
    var uuid: String
    
    var date: Date
    
    var error: ResponseError?
    
    var data: [MapPageData]
}

struct MapPageData: Decodable {
    let lat: Double
    let lon: Double
    let uid: Int
    let AQI: String
    let name: String
}
