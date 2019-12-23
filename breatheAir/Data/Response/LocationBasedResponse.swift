//
//  LocationBasedResponse.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-23.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation



struct LocationBasedResponse: BaseResponse,Decodable {
    var uuid: String = ""
    
    var date: Date = Date()
    
    var error: ResponseError = ResponseError(message: "", code: "", localeMessage: "")
    
    var location: LocationResponse = LocationResponse(lat: 0, lon: 0, name: "")
    
    var data: LocationBasedDataResponse = LocationBasedDataResponse(pm10: 0, pm2: 0, co2: 0, others: [])
    
    var offerToDo: [OfferToDo] = []
}

struct LocationResponse: Decodable {
    let lat: Double
    let lon: Double
    let name: String
}


struct LocationBasedDataResponse: Decodable {
    let pm10: Double
    let pm2: Double
    let co2: Double
    let others:[Double]?
}


struct OfferToDo: Decodable {
    let imageUrl: String
    let text: String
}
