import Foundation

public extension Int {

    /// Converts an integer to its string representation.
    ///
    /// - Returns: A string representation of the integer.
    ///
    /// Example:
    /// ```
    /// let num: Int? = 5
    /// let text: String = num?.toString ?? ""
    /// ```
    var toString: String {
        "\(self)"
    }
}
