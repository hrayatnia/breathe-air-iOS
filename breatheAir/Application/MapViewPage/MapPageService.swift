//
//  MapPageService.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift

struct MapPageService: Service {
    var result: Variable<MapPageService.ResultType>
    
    var err: Variable<Error>
    
    var request: RequestBuilder {
        self.buildRequest(path: "world")
            .set(method: .get)
    }
    typealias ResultType = MapPageResponse
    
    init(result:Variable<MapPageService.ResultType>,
         err: Variable<Error>) {
        self.result = result
        self.err = err
    }
    
    
}
