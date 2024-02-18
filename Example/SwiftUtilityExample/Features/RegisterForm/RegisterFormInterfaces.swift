import UIKit

protocol RegisterFormRouterInterface: RouterInterface {
    func navigateToMainScreen()
    func showSuccessAlert()
}

// View

protocol RegisterFormViewInterface: ViewInterface {
    func recalculateTableViewCellHeight()
    func tableViewReload()
}

// Presenter

protocol RegisterFormPresenterInterface: PresenterInterface {
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForRowAt(_ indexPath: IndexPath) -> RegisterFormEntity.ViewModel.Row?
    func titleForHeaderInSection(_ section: Int) -> String?
}

// Interactor

protocol RegisterFormInteractorInterface: InteractorInterface {
    var data: RegisterFormEntity.DataSource { get }
    var errorMessage: RegisterFormEntity.ErrorMessage { get }
    
    // setter
    func setAccount(_ account: String?)
    func setAge(_ age: Int?)
    func setPassword(_ password: String?)
    func setConfirmPassword(_ confirmPassword: String?)
    
    // validation
    func validateAll(dataSource: RegisterFormEntity.DataSource) -> Bool
    func validateAccount(_ text: String?) -> String?
    func validateAge(_ text: String?) -> String?
    func validatePassword(_ text: String?) -> String?
    func validateConfirmPassword(_ text: String?, password: String?) -> String?
}
