import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    static let api = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation
import OSLog

public class <{ apiName }> {

    internal let configuration: <{ apiName }>Configuration
    internal let scaffolding: any <{ apiName }>Scaffolding
    private let requestBuilder: any <{ apiName }>RequestBuilder
    private let requestPerformer: any <{ apiName }>RequestPerformer
    private let responseValidator: any <{ apiName }>ResponseValidator

    public init(
        configuration: <{ apiName }>Configuration,
        scaffolding: any <{ apiName }>Scaffolding = .default,
        requestBuilder: any <{ apiName }>RequestBuilder = .default,
        requestPerformer: any <{ apiName }>RequestPerformer = .default,
        responseValidator: any <{ apiName }>ResponseValidator = .default
    ) {
        self.configuration = configuration
        self.scaffolding = scaffolding
        self.requestBuilder = requestBuilder
        self.requestPerformer = requestPerformer
        self.responseValidator = responseValidator
    }

    // MARK: Make Request

    internal func makeRequest(
        _ method: HTTPMethod,
        _ path: String,
        body: Codable? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        query: [(String, String?)] = [],
        headers: [(String, String?)] = []
    ) throws -> (URLRequest, id: Int) {
        try requestBuilder.makeRequest(
            baseURL: configuration.baseURL,
            method: method,
            path: path,
            body: body,
            encoder: encoder,
            query: query,
            headers: headers,
            authorizeRequest: scaffolding.authorizeRequest(_:)
        )
    }

    // MARK: Perform Request

    internal func performRequest(_ request: URLRequest, id: Int) async throws -> (Data, HTTPURLResponse) {
        try await requestPerformer.performRequest(
            request: request,
            id: id,
            urlSession: scaffolding.urlSession,
            logger: scaffolding.logger
        )
    }

    // MARK: Validate Response

    internal func validateResponse(_ response: HTTPURLResponse, body: Data?, id: Int, in range: ClosedRange<Int>) throws {
        try responseValidator.validateResponse(
            response,
            body: body,
            id: id,
            in: range,
            logger: scaffolding.logger
        )
    }
}
"""#)
}
