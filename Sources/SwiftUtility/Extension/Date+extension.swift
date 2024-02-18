import Foundation

public extension Date {
    
    /// Converts a Date object to its string representation using the specified date format.
    ///
    /// - Parameter dateFormat: A string specifying the date format to use. Defaults to "yyyy-M-d".
    /// - Returns: A string representation of the Date object in the specified date format.
    ///
    /// Example:
    /// ```
    /// let date = Date()
    /// let dateString: String = date.toString() // Uses default format "yyyy-M-d"
    /// let customDateString: String = date.toString(format: "MM/dd/yyyy") // Custom format
    /// ```
    func toString(format dateFormat: String = "yyyy-M-d") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
