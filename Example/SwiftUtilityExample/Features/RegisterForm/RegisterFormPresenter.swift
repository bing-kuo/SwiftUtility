import Foundation
import SwiftUtility

class RegisterFormPresenter: RegisterFormPresenterInterface {
    
    typealias Section = RegisterFormEntity.ViewModel.Section
    typealias Row = RegisterFormEntity.ViewModel.Row
    
    // MARK: - Properties

    private unowned let view: RegisterFormViewInterface
    private let interactor: RegisterFormInteractorInterface
    private let router: RegisterFormRouterInterface
    
    var sections: [Section] { generateSections() }

    // MARK: - Constructors

    init(
        view: RegisterFormViewInterface,
        interactor: RegisterFormInteractorInterface,
        router: RegisterFormRouterInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Extension

extension RegisterFormPresenter {
    
    func generateSections() -> [Section] {
        return [
            Section(header: nil, rows: [
                .textField(
                    .init(
                        title: "Name",
                        text: interactor.data.account,
                        errorText: interactor.errorMessage.account,
                        onValidate: { [weak self] text in
                            self?.interactor.validateAccount(text)
                        }
                    ),
                    .init(textUpdatedHandler: { [weak self] text in
                        self?.interactor.setAccount(text)
                        self?.view.recalculateTableViewCellHeight()
                    })
                ),
                .textField(
                    .init(
                        title: "Age",
                        text: interactor.data.age?.toString,
                        errorText: interactor.errorMessage.age,
                        category: .number,
                        onValidate: { [weak self] text in
                            self?.interactor.validateAge(text)
                        },
                        onFormat: { text in
                            Validation(rules: [DigitValidationRule(errorMessage: "")])
                                .evaluate(with: text)
                                .isEmpty
                        }
                    ),
                    .init(textUpdatedHandler: { [weak self] text in
                        self?.interactor.setAge(text?.integer)
                        self?.view.recalculateTableViewCellHeight()
                    })
                ),
                .textField(
                    .init(
                        title: "Password",
                        text: interactor.data.password,
                        errorText: interactor.errorMessage.password,
                        category: .password,
                        onValidate: { [weak self] text in
                            self?.interactor.validatePassword(text)
                        }
                    ),
                    .init(textUpdatedHandler:  { [weak self] text in
                        self?.interactor.setPassword(text)
                        self?.view.recalculateTableViewCellHeight()
                    })
                ),
                .textField(
                    .init(
                        title: "Confirm Password",
                        text: interactor.data.confirmPassword,
                        errorText: interactor.errorMessage.confirmPassword,
                        category: .password,
                        onValidate: { [weak self] text in
                            self?.interactor.validateConfirmPassword(text, password: self?.interactor.data.password)
                        }
                    ),
                    .init(textUpdatedHandler:  { [weak self] text in
                        self?.interactor.setConfirmPassword(text)
                        self?.view.recalculateTableViewCellHeight()
                    })
                ),
            ]),
            Section(header: nil, rows: [
                .button(
                    .init(title: "Submit", category: .normal),
                    .init(clickActionHandler: { [weak self] in
                        guard let self else { return }
                        let result = self.interactor.validateAll(dataSource: self.interactor.data)
                        self.view.tableViewReload()
                        if result {
                            self.router.showSuccessAlert()
                        }
                    })
                )
            ])
        ]
    }
}

// MARK: - Router

extension RegisterFormPresenter {
    func navigateToMainScreen() {
        router.navigateToMainScreen()
    }
}

// MARK: - UITableView

extension RegisterFormPresenter {
    
    func numberOfSections() -> Int {
        sections.count
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        sections[section].rows.count
    }

    func cellForRowAt(_ indexPath: IndexPath) -> Row? {
        sections[indexPath.section].rows[indexPath.row]
    }

    func titleForHeaderInSection(_ section: Int) -> String? {
        sections[section].header
    }
}
