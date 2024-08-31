import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    /// - markComment
    /// - functionComment
    /// - functionName
    /// - httpMethod
    /// - endpointPath
    /// - body
    /// - query
    /// - headers
    /// - responseName
    static let request = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

extension <{ apiName }> {

    // MARK: - <{ markComment }>

    /// <{ functionComment }>
    public func <{ functionName }>() async throws -> <{ responseName }> {

        let (request, id) = try makeRequest(
            <{ httpMethod }>,
            "<{ path }>",
            body: <{ body }>,
            query: <{ query }>,
            headers: <{ headers }>
        )

        let (data, response) = try await performRequest(request, id: id)
        try validateResponse(response, body: data, id: id, in: 200...299)

        let decoder = scaffolding.defaultJSONDecoder
        let result = try decoder.decode(<{ responseName }>.self, from: data)

        return result
    }
}
"""#)

    static let request2 = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

extension <{ apiName }> {

    // MARK: - <{ markComment }>

    /// <{ functionComment }>
    func <{ functionName }>() async throws -> <{ responseName }> {

        let (request, id) = try makeRequest(
            <{ httpMethod }>,
            "<{ endpointPath }>",
            body: <{ body }>,
            query: <{ query }>,
            headers: <{ headers }>
        )

        let (data, response) = try await performRequest(request, id: id)
        try validateResponse(response, body: data, id: id, in: 200...299)

        let decoder = scaffolding.defaultJSONDecoder
        let result = try decoder.decode(<{ responseName }>.self, from: data)

        return result
    }
}
"""#)
}
