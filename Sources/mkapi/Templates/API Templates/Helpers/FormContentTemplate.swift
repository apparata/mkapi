import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    static let formContent = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

/// Builds a form string of content type application/x-www-form-urlencoded
public struct FormContent {

    public let contentType: MIMEContentType = .form

    public let encodedString: String

    public var data: Data {
        return encodedString.data(using: .utf8) ?? Data()
    }

    public init(fields: (String, String)...) {
        self.init(fields: fields)
    }

    public init(fields: [(String, String)]) {
        var encodedFields: [String] = []
        for (key, value) in fields {
            let encodedKey = Self.encode(string: key)
            let encodedValue = Self.encode(string: value)
            let field = "\(encodedKey)=\(encodedValue)"
            encodedFields.append(field)
        }
        encodedString = encodedFields.joined(separator: "&")
    }

    public init(fields: [String: String]) {
        self.init(fields: fields.map { ($0, $1) })
    }

    private static func encode(string: String) -> String {
        let encodedString = string.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved)
        return encodedString ?? string
    }
}

fileprivate extension CharacterSet {
    static let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}
"""#)
}
