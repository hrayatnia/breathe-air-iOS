//
//  HomeService.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift

struct HomeService: Service {
    var result: Variable<HomeService.ResultType>
    
    var err: Variable<Error>
    
    var request: RequestBuilder {
        self.buildRequest(path: "location")
            .set(method: .post)
            .set(body: data.toJSONData()!)
    }
    private var data: Location
    typealias ResultType = LocationBasedResponse
    
    init(data: Location,
         result:Variable<HomeService.ResultType>,
         err: Variable<Error>) {
        self.data = data
        self.result = result
        self.err = err
    }
    
    
}
