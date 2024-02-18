import Foundation
import SwiftUtility

enum RegisterFormEntity {
    
    struct DataSource {
        var account: String?
        var age: Int?
        var password: String?
        var confirmPassword: String?
    }
    
    struct ErrorMessage {
        var account: String?
        var age: String?
        var password: String?
        var confirmPassword: String?
    }
    
    enum ViewModel {
        struct Section {
            let header: String?
            let rows: [Row]
        }

        enum Row {
            case textField(TextFieldTableViewCell.Input, TextFieldTableViewCell.Output)
            case button(ButtonTableViewCell.Input, ButtonTableViewCell.Output)
        }
    }
}
