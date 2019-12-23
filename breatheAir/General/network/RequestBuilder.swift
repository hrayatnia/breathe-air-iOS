//
//  RequestBuilder.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import CocoaLumberjack
import Alamofire

typealias JSON = [String: AnyObject]

class RequestBuilder: URLRequestConvertible {
    fileprivate var request: URLRequest

    /// initial
    ///
    /// - Parameter url: URL object
    init(url: URL) {
        request = URLRequest(url: url)

        defaultInit()
    }

    /// default initial
    fileprivate func defaultInit() {
        set(method: .get)
        set(timeInterval: .default)
    }

    /// set
    ///
    /// - Parameter url: request URL
    /// - Returns: itself
    @discardableResult
    func set(url: URL) -> RequestBuilder {
        request.url = url
        return self
    }

    /// set
    ///
    /// - Parameter method: HTTPMethod
    /// - Returns: itself
    @discardableResult
    func set(method: HTTPMethod) -> RequestBuilder {
        request.httpMethod = method.rawValue
        return self
    }

    /// set
    ///
    /// - Parameter timeInterval: custom timeout interval
    /// - Returns: itself
    @discardableResult
    func set(timeInterval: RequestTimeoutInterval) -> RequestBuilder {
        request.timeoutInterval = timeInterval.rawValue
        return self
    }

    /// set
    ///
    /// - Parameters:
    ///   - json: json data
    ///   - encoding: encoding type
    /// - Returns: itself
    @discardableResult
    func set(json: JSON, encoding: JSONEncoding = .default) -> RequestBuilder {
        Logger.shared.log("\(json)")
        guard let request = try? encoding.encode(self.request, with: json) else {
            fatalError("jsonEncoding failed. encoding: \(encoding), json: \(json)")
        }
        self.request = request
        return self
    }

    /// set
    ///
    /// - Parameters:
    ///   - json: it's parameter base encoding
    ///   - encoding: ..
    /// - Returns: itself
    @discardableResult
    func set(json: Parameters, encoding: JSONEncoding = .default) -> RequestBuilder {
        Logger.shared.log("\(json)")
        guard let request = try? encoding.encode(self.request, with: json) else {
            fatalError("jsonEncoding failed. encoding: \(encoding), parameters: \(json)")
        }
        self.request = request
        return self
    }

    /// set
    ///
    /// - Parameters:
    ///   - parameters: url parameter
    ///   - encoding: url parameter base encoding system
    /// - Returns: itself
    @discardableResult
    func set(parameters: Parameters, encoding: URLEncoding = .default) -> RequestBuilder {

        guard let request = try? encoding.encode(self.request, with: parameters) else {
            fatalError("urlEncoding failed. encoding: \(encoding), parameters: \(parameters)")
        }
        self.request = request
        return self
    }

    /// Set
    ///
    /// - Parameter headers: HTTP Header
    /// - Returns: Request Builder
    @discardableResult
    func set(headers: HTTPHeaders) -> RequestBuilder {
//        DispatchQueue.main.async {
//            Logger.shared.log("\(headers)")
//        }

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return self
    }

    /// set
    ///
    /// - Parameter body: Data (request body data)
    /// - Returns: itself
    @discardableResult
    func set(body: Data) -> RequestBuilder {
        Logger.shared.log("\(body)")
        request.httpBody = body
        return self
    }

    @discardableResult
    func set(body: Encodable) -> RequestBuilder {
        let data = body.toJSONData()
        request.httpBody = data
        return self
    }

    func asURLRequest() throws -> URLRequest {
        return request
    }
}
