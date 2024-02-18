import Foundation

public enum UIState<T> {
    case loading
    case content(T)
    case error(Error)
}
