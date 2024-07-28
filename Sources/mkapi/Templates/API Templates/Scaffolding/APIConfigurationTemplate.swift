import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - baseURL
    /// - apiName
    static let configuration = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

public struct <{ apiName }>Configuration {

    public let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
"""#)
}
