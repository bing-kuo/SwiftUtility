import Foundation

open class Validator {
    
    private var rules: [RegexRule]
    
    public init(rules: [RegexRule] = []) {
        self.rules = rules
    }
    
    public func addRule(rule: RegexRule) {
        rules.append(rule)
    }
    
    open func evaluate(with text: String) -> [RegexRule] {
        var mismatchRules = [RegexRule]()
        for rule in rules {
            if !rule.evaluate(text) {
                mismatchRules.append(rule)
            }
        }
        return mismatchRules
    }
    
    open func mappingError(with rules: [RegexRule]) -> String? {
        return nil
    }
}
