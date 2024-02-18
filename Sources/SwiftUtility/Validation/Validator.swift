import Foundation

open class Validation {

    private var rules: [ValidationRule]

    public init() {
        self.rules = []
    }

    public init(rules: [ValidationRule]) {
        self.rules = rules
    }

    public func addRule(_ rule: ValidationRule) {
        rules.append(rule)
    }

    public func removeAllRules() {
        rules = []
    }

    open func evaluate(with text: String?) -> [ValidationRule] {
        var mismatchRules = [ValidationRule]()
        for rule in rules {
            if !rule.evaluate(text) {
                mismatchRules.append(rule)
            }
        }
        return mismatchRules
    }

    open func mappingError(with rules: [ValidationRule]) -> String? {
        return nil
    }
}
