import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    static let scaffolding = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

public protocol <{ apiName }>Scaffolding {
    var urlSession: URLSession { get }
    var defaultJSONEncoder: JSONEncoder { get }
    var defaultJSONDecoder: JSONDecoder { get }
    var logger: (any <{ apiName }>Logger)? { get }
    func authorizeRequest(_ request: URLRequest) throws -> URLRequest
}

public extension <{ apiName }>Scaffolding {

    var urlSession: URLSession {
        .shared
    }

    var defaultJSONEncoder: JSONEncoder {
        JSONEncoder()
    }

    var defaultJSONDecoder: JSONDecoder {
        JSONDecoder()
    }

    var logger: (any <{ apiName }>Logger)? { nil }

    func authorizeRequest(_ request: URLRequest) throws -> URLRequest {
        request
    }
}

extension <{ apiName }>Scaffolding where Self == Default<{ apiName }>Scaffolding {
    public static var `default`: any <{ apiName }>Scaffolding { Default<{ apiName }>Scaffolding() }
}

// MARK: Default API Scaffolding

public class Default<{ apiName }>Scaffolding: <{ apiName }>Scaffolding {

    public var logger: (any <{ apiName }>Logger)?

    public init(logger: (any <{ apiName }>Logger)? = Default<{ apiName }>Logger()) {
        self.logger = logger
    }
}
"""#)
}
