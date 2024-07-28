import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    static let logger = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation
import OSLog

public protocol <{ apiName }>Logger {
    func logRequest(_ request: URLRequest, id: Int)
    func logResponse(_ response: HTTPURLResponse, body: Data?, id: Int)
    func logErrorStatus(_ statusCode: Int, response: HTTPURLResponse, body: Data?, id: Int)
    func logError(_ error: Swift.Error, id: Int)
}

public extension <{ apiName }>Logger {
    func logRequest(_ request: URLRequest, id: Int) {}
    func logResponse(_ response: HTTPURLResponse, body: Data?, id: Int) {}
    func logErrorStatus(_ statusCode: Int, response: HTTPURLResponse, body: Data?, id: Int) {}
    func logError(_ error: Swift.Error, id: Int) {}
}

// MARK: - Default API Logger

public class Default<{ apiName }>Logger: <{ apiName }>Logger {

    public var logsRequest: Bool
    public var logsRequestBody: Bool
    public var logsResponse: Bool
    public var logsResponseBody: Bool

    public init(
        logsRequest: Bool = true,
        logsRequestBody: Bool = false,
        logsResponse: Bool = true,
        logsResponseBody: Bool = false
    ) {
        self.logsRequest = logsRequest
        self.logsRequestBody = logsRequestBody
        self.logsResponse = logsResponse
        self.logsResponseBody = logsResponseBody
    }


    public func logRequest(_ request: URLRequest, id: Int) {
        #if DEBUG
        if logsRequest {
            Logger.api.trace("🪧➡️ #\(id) \(request.httpMethod ?? "GET") \(request.url?.path ?? "N/A")")
            if logsRequestBody {
                if let body = request.httpBody, let string = String(data: body, encoding: .utf8) {
                    Logger.api.trace("\(string)")
                }
            }
        }
        #endif
    }
    
    public func logResponse(_ response: HTTPURLResponse, body: Data?, id: Int) {
        #if DEBUG
        if logsResponse {
            Logger.api.trace("🪧⬅️ #\(id) \(response.statusCode)")
            if logsResponseBody {
                if let body, let string = String(data: body, encoding: .utf8) {
                    Logger.api.trace("\(string)")
                }
            }
        }
        #endif
    }

    public func logErrorStatus(_ statusCode: Int, response: HTTPURLResponse, body: Data?, id: Int) {
        Logger.api.error("⚠️ Error: HTTP status \(statusCode) (id: \(id))")
    }
    
    public func logError(_ error: Swift.Error, id: Int) {
        Logger.api.error("⚠️ Error: Invalid HTTP response (id: \(id))")
    }
}
"""#)
}
