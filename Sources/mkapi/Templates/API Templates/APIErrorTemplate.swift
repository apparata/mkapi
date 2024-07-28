import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    static let error = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

public enum <{ apiName }>Error: Swift.Error {
    case invalidURL
    case invalidHTTPResponse
    case httpError(Int, body: Data?)
    case underlying(Swift.Error)
}
"""#)
}
