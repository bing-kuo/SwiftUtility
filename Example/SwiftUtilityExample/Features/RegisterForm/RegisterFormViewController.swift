import UIKit
import SwiftUtility

class RegisterFormViewController: UIViewController {

    // MARK: - Properties

    var presenter: RegisterFormPresenterInterface!
    
    // MARK: - UI Components

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.registerDefaultCustomTableViewCell()
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - ViewInterface

extension RegisterFormViewController: RegisterFormViewInterface {
    
    func recalculateTableViewCellHeight() {
        UIView.performWithoutAnimation {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: - Setup UI

extension RegisterFormViewController {
    
    func setupUI() {
        view.backgroundColor = .white
    
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension RegisterFormViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = presenter.cellForRowAt(indexPath) else { return UITableViewCell() }

        var tableViewCell = UITableViewCell()
        
        switch data {
        case let .textField(input, output):
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier) as? TextFieldTableViewCell {
                cell.configure(input: input, output: output)
                tableViewCell = cell
            }
        case let .button(input, output):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier) as? ButtonTableViewCell {
                cell.configure(input: input, output: output)
                tableViewCell = cell
            }
        }

        tableViewCell.setFullWidthOfSeparator()
        
        return tableViewCell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.titleForHeaderInSection(section)
    }
}
