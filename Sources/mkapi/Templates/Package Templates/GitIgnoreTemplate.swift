import Foundation
import TemplateKit

extension Template.Package {
    static let gitignore = Template(#"""
# macOS stuff
.DS_Store

# User settings and state
xcuserdata/

# Just in case these make it into your repo directory, somehow
*.ipa
*.dSYM.zip
*.dSYM

# Swift Package Manager adds these to its default .gitignore
.build/
DerivedData/
.swiftpm/config/registries.json
.swiftpm/xcode/package.xcworkspace/contents.xcworkspacedata
.netrc

# It's not entirely uncommon that "build/" is used for build results
build/

# Just in case the compiler still creates these files
*.hmap
"""#)
}
