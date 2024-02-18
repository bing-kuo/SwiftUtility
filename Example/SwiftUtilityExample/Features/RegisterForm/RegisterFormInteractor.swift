import Foundation
import SwiftUtility

class RegisterFormInteractor: RegisterFormInteractorInterface {
    
    private(set) var data: RegisterFormEntity.DataSource
    private(set) var errorMessage: RegisterFormEntity.ErrorMessage
    
    // MARK: - Constructors
    
    init() {
        self.data = RegisterFormEntity.DataSource()
        self.errorMessage = RegisterFormEntity.ErrorMessage()
    }
    
    // MARK: - Setter
    
    func setAccount(_ account: String?) {
        data.account = account
    }
    
    func setAge(_ age: Int?) {
        data.age = age
    }
    
    func setPassword(_ password: String?) {
        data.password = password
    }
    
    func setConfirmPassword(_ confirmPassword: String?) {
        data.confirmPassword = confirmPassword
    }
    
    // MARK: - Validate
    
    func validateAll(dataSource: RegisterFormEntity.DataSource) -> Bool {
        let result = [
            validateAccount(dataSource.account),
            validateAge(dataSource.age?.toString),
            validatePassword(dataSource.password),
            validateConfirmPassword(dataSource.confirmPassword, password: dataSource.password)
        ].compactMap { $0 }
        return result.isEmpty
    }
    
    func validateAccount(_ text: String?) -> String? {
        guard !text.isEmptyOrNil else {
            errorMessage.account = "Field shouldn't be empty."
            return errorMessage.account
        }
        let validation = Validation(rules: [
            EmailValidationRule(errorMessage: "Email address format is incorrect.")
        ])
        
        let result = validation.evaluate(with: text)
        if result.isEmpty {
            errorMessage.account = nil
        } else {
            let error = result.map(\.errorMessage).joined(separator: "\n")
            errorMessage.account = error
        }
        return errorMessage.account
    }
    
    func validateAge(_ text: String?) -> String? {
        guard !text.isEmptyOrNil else {
            errorMessage.age = "Field shouldn't be empty."
            return errorMessage.age
        }
        let validation = Validation(rules: [
            DigitValidationRule(errorMessage: "Field should be a number.")
        ])
        
        let result = validation.evaluate(with: text)
        if result.isEmpty {
            errorMessage.age = nil
        } else {
            let error = result.map(\.errorMessage).joined(separator: "\n")
            errorMessage.age = error
        }
        return errorMessage.age
    }
    
    func validatePassword(_ text: String?) -> String? {
        guard !text.isEmptyOrNil else {
            errorMessage.password = "Field shouldn't be empty."
            return errorMessage.password
        }
        let validation = Validation(rules: [
            LengthValidationRule(range: 6...12, errorMessage: "Password must be between 6 and 12 characters long."),
            AtLeastOneLowercaseRegexRule(),
            AtLeastOneUppercaseRegexRule(),
            AtLeastOneSpecialSymbolsRegexRule(),
        ])
        
        let result = validation.evaluate(with: text)
        if result.isEmpty {
            errorMessage.password = nil
        } else {
            let error = result.map(\.errorMessage).joined(separator: "\n")
            errorMessage.password = error
        }
        return errorMessage.password
    }
    
    func validateConfirmPassword(_ text: String?, password: String?) -> String? {
        guard !text.isEmptyOrNil else {
            errorMessage.confirmPassword = "Field shouldn't be empty."
            return errorMessage.confirmPassword
        }
        guard (text == password) else {
            errorMessage.confirmPassword = "Confirmation password must be the same as the password."
            return errorMessage.confirmPassword
        }
        errorMessage.confirmPassword = nil
        return errorMessage.confirmPassword
    }
}
