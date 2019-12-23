//
//  Service.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import RxSwift
protocol Service: AnyService {
    var result: Variable<ResultType> { get set }
    var err: Variable<Error> { get set }
    var request: RequestBuilder { get }
}

extension Service {

    /// build Reuqests
    ///
    /// - Parameter path: service endpoint
    /// - Returns: a request builder object
    func buildRequest(path: String) -> RequestBuilder {
        guard let url = URL(string: "\(AppSetting.BaseURL)\(AppSetting.APIVersion)\(AppSetting.APIToken)/\(path)") else {
            Logger.shared.log("[Network Error] :- Wrong baseUrl.")
            fatalError("[Network Error] :- Wrong baseUrl.")
        }
        let finalURL = RequestBuilder(url: url)
        finalURL.set(headers: ["Accept": "application/json",
                               "Content-Type": "application/json"])
        return finalURL
    }

    func run_request() {
        self.run(input: self.request, returnValue: self.result, error: self.err)
    }
}
