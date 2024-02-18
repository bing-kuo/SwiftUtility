import Foundation

public protocol ValidationRule {
    var errorMessage: String { get }
    
    func evaluate(_ text: String?) -> Bool
}

public struct DigitValidationRule: ValidationRule {
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func evaluate(_ text: String?) -> Bool {
        guard let text else { return false }
        return text.isMatch(regex: "^[0-9]+$")
    }
}

public struct NumericValidationRule: ValidationRule {
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func evaluate(_ text: String?) -> Bool {
        guard let text else { return false }
        return text.isMatch(regex: "^[0-9]+\\.?[0-9]*$")
    }
}

public struct TextValidationRule: ValidationRule {
    public let errorMessage: String
    let text: String
    
    public init(text: String, errorMessage: String) {
        self.text = text
        self.errorMessage = errorMessage
    }
    
    public func evaluate(_ text: String?) -> Bool {
        self.text == text
    }
}

public struct LengthValidationRule: ValidationRule {
    public let errorMessage: String
    let range: ClosedRange<UInt>
    
    public init(range: ClosedRange<UInt>, errorMessage: String) {
        self.range = range
        self.errorMessage = errorMessage
    }
    
    public func evaluate(_ text: String?) -> Bool {
        guard let text else { return false }
        return text.isMatch(regex: "^.{\(range.lowerBound),\(range.upperBound)}$")
    }
}

public struct EmailValidationRule: ValidationRule {
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func evaluate(_ text: String?) -> Bool {
        guard let text else { return false }
        return text.isMatch(regex: "^[\\w\\.-]+@[\\w\\.-]+\\.[\\w\\.-]{2,6}$")
    }
}
