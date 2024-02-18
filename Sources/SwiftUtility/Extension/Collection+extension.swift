import Foundation

public extension Collection {
    
    /// Safely accesses the element at the specified position.
    ///
    /// - Parameter index: An index within the bounds of the collection, or outside of it to safely return nil.
    /// - Returns: The element at the specified index if it is within bounds, or nil if the index is out of bounds.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
