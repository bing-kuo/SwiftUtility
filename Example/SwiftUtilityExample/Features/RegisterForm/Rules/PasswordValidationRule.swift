import Foundation
import SwiftUtility

struct AtLeastOneLowercaseRegexRule: ValidationRule {
    let errorMessage = "Password must contain at least one lowercase letter."
    
    func evaluate(_ text: String?) -> Bool {
        guard let text else { return false }
        return text.isMatch(regex: "(?=.*[a-z])")
    }
}

struct AtLeastOneUppercaseRegexRule: ValidationRule {
    let errorMessage = "Password must contain at least one uppercase letter."
    
    func evaluate(_ text: String?) -> Bool {
        guard let text else { return false }
        return text.isMatch(regex: "(?=.*[A-Z])")
    }
}

struct AtLeastOneSpecialSymbolsRegexRule: ValidationRule {
    let errorMessage = "Password must contain at least one special symbol"
    
    func evaluate(_ text: String?) -> Bool {
        guard let text else { return false }
        return text.isMatch(regex: "(?=.*[%@&$-])")
    }
}
