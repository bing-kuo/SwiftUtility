//
//  RegisterFormInteractorTests.swift
//  SwiftUtilityExampleTests
//
//  Created by Bing Kuo on 2024/2/18.
//

import XCTest
@testable import SwiftUtilityExample

final class RegisterFormInteractorTests: XCTestCase {

    var interactor: RegisterFormInteractor!
    
    override func setUpWithError() throws {
        interactor = RegisterFormInteractor()
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testSetter() throws {
        let account = "test@example.com"
        interactor.setAccount(account)
        XCTAssertEqual(interactor.data.account, account)
        
        let age = 20
        interactor.setAge(age)
        XCTAssertEqual(interactor.data.age, age)
        
        let password = "Test@12345"
        interactor.setPassword(password)
        XCTAssertEqual(interactor.data.password, password)
        
        let confirmPassword = "Test@12345"
        interactor.setConfirmPassword(confirmPassword)
        XCTAssertEqual(interactor.data.confirmPassword, confirmPassword)
    }

    func testValidateAccount() {
        var account: String? = nil
        var result = interactor.validateAccount(account)
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.account, "Field shouldn't be empty.")
        
        account = "invalid_email"
        result = interactor.validateAccount(account)
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.account, "Email address format is incorrect.")
        
        account = "test@example.com"
        result = interactor.validateAccount(account)
        XCTAssertTrue(result.isNil)
        XCTAssertNil(interactor.errorMessage.account)
    }
    
    func testValidateAge() {
        var age: String? = nil
        var result = interactor.validateAge(age)
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.age, "Field shouldn't be empty.")
        
        age = "abc"
        result = interactor.validateAge(age)
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.age, "Field should be a number.")
        
        age = "20"
        result = interactor.validateAge(age)
        XCTAssertTrue(result.isNil)
        XCTAssertNil(interactor.errorMessage.age)
    }
    
    func testValidatePassword() {
        var password: String? = nil
        var result = interactor.validatePassword(password)
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.password, "Field shouldn't be empty.")
        
        password = "12345"
        result = interactor.validatePassword(password)
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.password, """
        Password must be between 6 and 12 characters long.
        Password must contain at least one lowercase letter.
        Password must contain at least one uppercase letter.
        Password must contain at least one special symbol
        """)
        
        password = "Test@12345"
        result = interactor.validatePassword(password)
        XCTAssertTrue(result.isNil)
        XCTAssertNil(interactor.errorMessage.password)
    }

    func testValidateConfirmPassword() {
        var confirmPassword: String? = nil
        var result = interactor.validateConfirmPassword(confirmPassword, password: "Test@12345")
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.confirmPassword, "Field shouldn't be empty.")
        
        confirmPassword = "12345"
        result = interactor.validateConfirmPassword(confirmPassword, password: "Test@12345")
        XCTAssertFalse(result.isNil)
        XCTAssertEqual(interactor.errorMessage.confirmPassword, "Confirmation password must be the same as the password.")
        
        confirmPassword = "Test@12345"
        result = interactor.validateConfirmPassword(confirmPassword, password: "Test@12345")
        XCTAssertTrue(result.isNil)
        XCTAssertNil(interactor.errorMessage.confirmPassword)
    }
    
    func testValidateAll() {
        interactor.setAccount("test@example.com")
        interactor.setAge(20)
        interactor.setPassword("Test@12345")
        interactor.setConfirmPassword("Test@12345")
        var result = interactor.validateAll(dataSource: interactor.data)
        XCTAssertTrue(result)
        
        interactor.setPassword("12345")
        result = interactor.validateAll(dataSource: interactor.data)
        XCTAssertFalse(result)
    }
    
    func testErrorMessages() {
        let _ = interactor.validateAccount(nil)
        XCTAssertEqual(interactor.errorMessage.account, "Field shouldn't be empty.")
        
        let _ = interactor.validateAge(nil)
        XCTAssertEqual(interactor.errorMessage.age, "Field shouldn't be empty.")
        
        let _ = interactor.validatePassword(nil)
        XCTAssertEqual(interactor.errorMessage.password, "Field shouldn't be empty.")
        
        let _ = interactor.validateConfirmPassword(nil, password: "123456")
        XCTAssertEqual(interactor.errorMessage.confirmPassword, "Field shouldn't be empty.")
    }
}
