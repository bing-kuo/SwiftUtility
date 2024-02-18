import Foundation

public extension Optional where Wrapped == String {

    var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }
}

public extension Optional {

    var isNil: Bool {
        self == nil
    }
}
