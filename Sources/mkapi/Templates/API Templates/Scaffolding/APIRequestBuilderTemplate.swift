import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    static let requestBuilder = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

public protocol <{ apiName }>RequestBuilder {
    func makeRequest(
        baseURL: URL,
        method: HTTPMethod,
        path: String,
        body: Codable?,
        encoder: JSONEncoder,
        query: [(String, String?)],
        headers: [(String, String?)],
        authorizeRequest: (URLRequest) throws -> URLRequest
    ) throws -> (URLRequest, id: Int)
}

extension <{ apiName }>RequestBuilder where Self == Default<{ apiName }>RequestBuilder {
    public static var `default`: any <{ apiName }>RequestBuilder { Default<{ apiName }>RequestBuilder() }
}

// MARK: - RequestBuilder

public class Default<{ apiName }>RequestBuilder: <{ apiName }>RequestBuilder {

    private let requestIDProvider: RequestIDProvider

    public init() {
        requestIDProvider = RequestIDProvider()
    }

    // MARK: Make Request

    public func makeRequest(
        baseURL: URL,
        method: HTTPMethod,
        path: String,
        body: Codable?,
        encoder: JSONEncoder,
        query: [(String, String?)],
        headers: [(String, String?)],
        authorizeRequest: (URLRequest) throws -> URLRequest
    ) throws -> (URLRequest, id: Int) {

        let queryItems = query.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }

        let url = try assembleURL(
            baseURL: baseURL,
            path: path,
            queryItems: queryItems
        )

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body {
            request.httpBody = try encoder.encode(body)
        }

        for (header, value) in headers {
            request.setValue(value, forHTTPHeaderField: header)
        }

        request = try authorizeRequest(request)

        let id = requestIDProvider.nextID()

        return (request, id: id)
    }

    // MARK: Assemble URL

    private func assembleURL(
        baseURL: URL,
        path: String,
        queryItems: [URLQueryItem]
    ) throws -> URL {
        if #available(iOS 16.0, *) {
            let url = baseURL
                .appending(path: path)
                .appending(queryItems: queryItems)
            return url
        } else {
            // Legacy
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.appendingPathComponent(path).path
            components.queryItems = queryItems
            guard let assembledURL = components.url else {
                throw <{ apiName }>Error.invalidURL
            }
            return assembledURL
        }

    }
}

// MARK: - Request ID Provider

private class RequestIDProvider {

    /// Increased by one for every request
    private var requestID: Int = 0
    private var requestLock = NSLock()

    func nextID() -> Int {
        var id: Int = 0
        requestLock.withLock {
            id = requestID
            requestID += 1
        }
        return id
    }
}
"""#)
}
