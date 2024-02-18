import Foundation

class JSONLoader {

    /// Loads a decodable object from a JSON file located in the main bundle.
    ///
    /// This method attempts to load a JSON file from the main bundle and decode it into an instance of the specified `Decodable` type. It throws a fatal error if the file cannot be found, the data cannot be loaded, or the decoding fails.
    ///
    /// - Parameter filename: The name of the JSON file to load.
    /// - Returns: An instance of the specified `Decodable` type.
    ///
    /// Example:
    /// ```
    /// let myObject: MyDecodableType = JSONLoader.load("data.json")
    /// ```
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard
            let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
