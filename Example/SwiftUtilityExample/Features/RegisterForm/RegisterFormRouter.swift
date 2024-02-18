import UIKit

class RegisterFormRouter: RegisterFormRouterInterface {

    // MARK: - Properties
    
    let viewController: UIViewController

    // MARK: - Module setup

    init() {
        let viewController = RegisterFormViewController()
        self.viewController = viewController
        
        let interactor = RegisterFormInteractor()
        let presenter = RegisterFormPresenter(
            view: viewController,
            interactor: interactor,
            router: self
        )
        viewController.presenter = presenter
    }
    
    func navigateToMainScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Register completed successfully.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigateToMainScreen()
        }
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.viewController.present(alert, animated: true, completion: nil)
        }
    }
}
