import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    static let multipartContent = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

import Foundation

public struct MultipartContent {

    public class Part {
        let contentDisposition: String
        let contentType: String
        let data: Data

        public init(name: String, filename: String, contentType: String, data: Data) {
            contentDisposition = "form-data; name=\"\(name)\"; filename=\"\(filename)\""
            self.contentType = contentType
            self.data = data
        }

        public init(name: String, contentType: String, data: Data) {
            contentDisposition = "form-data; name=\"\(name)\";"
            self.contentType = contentType
            self.data = data
        }
    }

    public let contentType: MIMEContentType

    public let boundary: String

    public let data: Data

    public init(parts: [Part]) {

        boundary = "Boundary-\(UUID().uuidString)"
        contentType = .multipart(boundary: boundary)

        var data = Data()

        for part in parts {
            data.appendString("--\(boundary)\r\n")
            data.appendString("Content-Disposition: \(part.contentDisposition)\r\n")
            data.appendString("Content-Type: \(part.contentType)\r\n\r\n")
            data.append(part.data)
            data.appendString("\r\n")
        }

        data.appendString("--".appending(boundary.appending("--")))

        self.data = data
    }
}

private extension Data {
    mutating func appendString(_ string: String) {
        append(string.data(using: .utf8) ?? Data())
    }
}
"""#)
}
