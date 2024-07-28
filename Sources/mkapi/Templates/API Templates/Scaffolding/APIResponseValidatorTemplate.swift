import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    static let responseValidator = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

public protocol <{ apiName }>ResponseValidator {
    func validateResponse(
        _ response: HTTPURLResponse,
        body: Data?,
        id: Int,
        in range: ClosedRange<Int>,
        logger: (any <{ apiName }>Logger)?
    ) throws
}

extension <{ apiName }>ResponseValidator where Self == Default<{ apiName }>ResponseValidator {
    public static var `default`: any <{ apiName }>ResponseValidator { Default<{ apiName }>ResponseValidator() }
}

// MARK: - RequestValidator

public class Default<{ apiName }>ResponseValidator: <{ apiName }>ResponseValidator {

    init() {
        //
    }

    // MARK: Validate Response

    public func validateResponse(
        _ response: HTTPURLResponse,
        body: Data?,
        id: Int,
        in range: ClosedRange<Int>,
        logger: (any <{ apiName }>Logger)?
    ) throws {
        let statusCode = response.statusCode
        switch statusCode {
        case range:
            break
        default:
            logger?.logErrorStatus(statusCode, response: response, body: body, id: id)
            throw <{ apiName }>Error.httpError(statusCode, body: body)
        }
    }
}
"""#)
}
