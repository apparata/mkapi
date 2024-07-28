//
//  Copyright © 2024 Bontouch AB. All rights reserved.
//

import Foundation

extension NavigationItem {

    struct General {
        static let package = NavigationItem(
            id: "package",
            title: "Package",
            subtitle: "API package setup",
            icon: "shippingbox"
        )
    }

    struct Configuration {
        static let development = NavigationItem(
            id: "development",
            title: "Development",
            subtitle: "The configuration used during development.",
            icon: "server.rack"
        )
    }

    struct Request {
        static let getStuff = NavigationItem(
            id: "getStuff",
            title: "Get Stuff",
            subtitle: "A request that will get stuff",
            icon: "arrow.left.arrow.right"
        )
    }
}
