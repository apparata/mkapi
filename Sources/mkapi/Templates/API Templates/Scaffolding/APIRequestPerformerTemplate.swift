import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    static let requestPerformer = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

public protocol <{ apiName }>RequestPerformer {
    func performRequest(
        request: URLRequest,
        id: Int,
        urlSession: URLSession,
        logger: (any <{ apiName }>Logger)?
    ) async throws -> (Data, HTTPURLResponse)
}

extension <{ apiName }>RequestPerformer where Self == Default<{ apiName }>RequestPerformer {
    public static var `default`: any <{ apiName }>RequestPerformer { Default<{ apiName }>RequestPerformer() }
}

// MARK: - Default Request Performer

public class Default<{ apiName }>RequestPerformer: <{ apiName }>RequestPerformer {

    init() {
        //
    }

    // MARK: Perform Request

    public func performRequest(
        request: URLRequest,
        id: Int,
        urlSession: URLSession,
        logger: (any <{ apiName }>Logger)?
    ) async throws -> (Data, HTTPURLResponse) {
        logger?.logRequest(request, id: id)
        let (data, response) = try await urlSession.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            logger?.logError(UntitledAPIError.invalidHTTPResponse, id: id)
            throw UntitledAPIError.invalidHTTPResponse
        }
        logger?.logResponse(httpResponse, body: data, id: id)
        return (data, httpResponse)
    }
}
"""#)
}
