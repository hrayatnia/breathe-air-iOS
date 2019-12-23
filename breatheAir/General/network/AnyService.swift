//
//  AnyService.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import Alamofire
import CocoaLumberjack
import RxSwift

/// Alamofire session manager which our request built up on that
private let sessionManager: Alamofire.SessionManager = { manager in
    manager.session.configuration.timeoutIntervalForRequest = RequestTimeoutInterval.fast.rawValue
    manager.session.configuration.timeoutIntervalForResource = RequestTimeoutInterval.default.rawValue
    return manager
}(Alamofire.SessionManager.default)

/// Any Service Protoctol
protocol AnyService {

    // MARK: - Result Data
    associatedtype ResultType: Decodable
}

// MARK: - Any Service Extension
extension AnyService {

    /// run method
    ///
    /// - Parameters:
    ///   - input: Request Builder Pattern
    ///   - returnValue: Decodable Data
    ///   - error: Message
    func run(input: RequestBuilder,
             returnValue: Variable<ResultType>,
             error: Variable<Error>) {

        do {
            sessionManager
                .request(try input.asURLRequest())
                .validate(statusCode: [200])
                .validate(contentType: ["application/json"])
                .debugLogs()
                .rxResponseDecodable(queue: networkQueue) {
                    (response: DataResponse<ResultType>) in

                    switch response.result {
                    case .success(let data):
                        returnValue.value = data
                    case .failure(let err):
                        error.value = err
                    }
            }
        } catch {
            Logger.shared.log("[Network Error] :- Invalid URL PATH")
        }

    }

    func cancelAll() {
        sessionManager.session.getTasksWithCompletionHandler {
            (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
        }
    }

}

// TODO:- Move this to data model group
struct ErrorMessage {

}

extension Request {
    public func debugLog() -> Request {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}
