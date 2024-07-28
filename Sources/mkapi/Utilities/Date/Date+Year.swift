import Foundation

extension Date {
    static var currentYear: Int {
        Calendar.current.component(.year, from: Date.now)
    }
}
