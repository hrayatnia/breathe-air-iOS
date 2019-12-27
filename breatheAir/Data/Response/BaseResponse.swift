//
//  BaseResponse.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-23.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation

struct ResponseError:Decodable {
    var message: String
    var code: String
    var localeMessage: String
}

protocol BaseResponse: Decodable {
    var uuid: String {get}
    var date: Date {get}
    var error: ResponseError?{get}
}
