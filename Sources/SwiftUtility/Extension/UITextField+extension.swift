import UIKit

public extension UITextField {
    
    /// Adds a Done button on the keyboard with a customizable color.
    ///
    /// This method creates a toolbar with a Done button and sets it as the input accessory view of the UITextField. Tapping the Done button dismisses the keyboard.
    ///
    /// - Parameter color: The color of the Done button. Defaults to `.blue`.
    ///
    /// Example:
    /// ```
    /// let textField = UITextField()
    /// textField.addDoneButtonOnKeyboard() // Adds a Done button with default color
    /// textField.addDoneButtonOnKeyboard(.red) // Adds a Done button with custom color
    /// ```
    func addDoneButtonOnKeyboard(_ color: UIColor = .systemBlue) {
       let keyboardToolbar = UIToolbar()
       keyboardToolbar.sizeToFit()

       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
       doneButton.tintColor = color
       keyboardToolbar.items = [flexibleSpace, doneButton]

       inputAccessoryView = keyboardToolbar
   }
}
