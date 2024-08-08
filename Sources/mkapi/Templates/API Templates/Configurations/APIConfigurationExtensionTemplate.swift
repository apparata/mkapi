import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    /// - apiName
    /// - title
    /// - propertyComment
    /// - propertyName
    /// - baseURL
    static let configurationExtension = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

extension <{ apiName }>Configuration {

    // MARK: - <{ title }>

    /// <{ propertyComment }>
    public static let <{ propertyName }> = <{ apiName }>Configuration(
        // swiftlint:disable:next force_unwrapping
        baseURL: URL(string: "<{ baseURL }>")!
    )
}
"""#)
}
