//
//  HomeViewController.swift
//  SwiftUtilityExample
//
//  Created by Bing Kuo on 2024/2/17.
//

import UIKit
import SwiftUtility

class HomeViewController: UIViewController {

    // MARK: - Properties

    let viewModel: HomeViewModel

    // MARK: - UI Components

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.isHidden = true
        tableView.registerDefaultCustomTableViewCell()
        return tableView
    }()

    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    // MARK: - Constructors

    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
        setupBinding()
        
        viewModel.loadData()
    }
}

// MARK: - Data Binding

private extension HomeViewController {

    func setupBinding() {
        viewModel.dataDidUpdateClosure = { [weak self] state in
            self?.tableView.isHidden = true
            self?.indicatorView.isHidden = true

            switch state {
            case .loading:
                self?.indicatorView.isHidden = false
            case .content:
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            case .error:
                self?.indicatorView.isHidden = false
            }
        }
    }
}

// MARK: - Actions

private extension HomeViewController {
    
}

// MARK: - Setup UI

private extension HomeViewController {

    func setupUI() {
        view.backgroundColor = .white
    
        view.addSubview(tableView)
        view.addSubview(indicatorView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setupNavigation() {
        /*
         let button = UIBarButtonItem(title: "Button", image: nil, target: self, action: #selector(action))
         navigationItem.rightBarButtonItem = button
        */
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = viewModel.cellForRowAt(indexPath) else { return UITableViewCell() }

        switch data {
        case let .registerForm(input, output):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as? ContentTableViewCell else { return UITableViewCell() }
            cell.configure(input: input, output: output)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.cellForRowAt(indexPath) else { return }
        
        switch data {
        case .registerForm:
            let router = RegisterFormRouter()
            navigationController?.pushViewController(router.viewController, animated: true)
        }
    }
}
