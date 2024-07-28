import SwiftUI

struct SidebarItem: View {

    private let item: NavigationItem

    init(_ item: NavigationItem) {
        self.item = item
    }

    var body: some View {
        Label(item.description, systemImage: item.icon)
            .tag(item)
    }
}

// MARK: - Preview

#if DEBUG
#Preview {
    SidebarItem(.Configuration.development)
}
#endif
