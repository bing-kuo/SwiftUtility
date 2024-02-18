import UIKit

public extension UIColor {

    /// Initializes a UIColor object using a hexadecimal color code and an optional alpha value.
    ///
    /// - Parameters:
    ///   - hex: A `String` representing the hexadecimal color code. It can start with '#' but it's optional.
    ///   - alpha: A `CGFloat` representing the alpha (opacity) of the color. It defaults to 1.0, which is fully opaque.
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

// MARK: - Common Colors

public extension UIColor {
    
    static var silverGray = UIColor(hex: "#EEEEEE")
}
