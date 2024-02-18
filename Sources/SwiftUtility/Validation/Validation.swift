import Foundation

public struct Validation {

    private var rules: [ValidationRule]

    public init(rules: [ValidationRule] = []) {
        self.rules = rules
    }

    public mutating func addRule(_ rule: ValidationRule) {
        rules.append(rule)
    }

    public mutating func removeAllRules() {
        rules = []
    }

    public func evaluate(with text: String?) -> [(ValidationRule)] {
        var mismatchRules = [ValidationRule]()
        for rule in rules {
            if !rule.evaluate(text) {
                mismatchRules.append(rule)
            }
        }
        return mismatchRules
    }
}
