import UIKit

public extension UITableViewCell {
    
    /// Provides a reusable identifier for UITableViewCell derived from the class name.
    ///
    /// - Returns: A string identifier for the UITableViewCell class.
    ///
    /// Example:
    /// ```
    /// let cellIdentifier = UITableViewCell.identifier
    /// tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    /// ```
    static var identifier: String {
        String(describing: Self.self)
    }
    
    func setFullWidthOfSeparator() {
        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        layoutMargins = .zero
    }
}

extension UITableViewCell {
    
    static let defaultPending = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    static let defaultSpacing: CGFloat = 4
    static let boldTitleFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
    static let titleFont: UIFont = .systemFont(ofSize: 16)
    static let contentFont: UIFont = .systemFont(ofSize: 14)
}
