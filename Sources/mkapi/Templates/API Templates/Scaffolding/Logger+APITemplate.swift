import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - loggerSubsystem
    /// - loggerCategory
    static let loggerExtension = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation
import OSLog

internal extension Logger {
    static let api = Logger(subsystem: "<{ loggerSubsystem }>", category: "<{ loggerCategory }>")
}
"""#)
}
