import UIKit

public extension String {
    
    /// Converts a String to an optional Int.
    ///
    /// - Returns: An optional Int if the string can be converted, otherwise nil.
    ///
    /// Example:
    /// ```
    /// let intValue: Int? = "123".integer
    /// ```
    var integer: Int? {
        Int(self)
    }
    
    /// Converts a String to an optional Double.
    ///
    /// - Returns: An optional Double if the string can be converted, otherwise nil.
    ///
    /// Example:
    /// ```
    /// let doubleValue: Double? = "123.45".double
    /// ```
    var double: Double? {
        Double(self)
    }
}

public extension String {
    
    func isMatch(regex regexString: String) -> Bool {
        if #available(iOS 16, *) {
            if let regex = try? Regex(regexString), !self.matches(of: regex).isEmpty {
                return true
            }
            return false
        } else {
            do {
                let regex = try NSRegularExpression(pattern: regexString)
                let range = NSRange(location: 0, length: self.utf16.count)
                let match = regex.firstMatch(in: self, options: [], range: range)
                return match != nil
            } catch {
                return false
            }
        }
    }
}
