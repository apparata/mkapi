import Foundation
import TemplateKit

extension Template.Package {
    /// Parameters:
    /// - packageName
    static let readme = Template(#"""
# <{ packageName }>

# License

See LICENSE file for more information.

"""#)
}
