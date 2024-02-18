//
//  HomeViewModel.swift
//  SwiftUtilityExample
//
//  Created by Bing Kuo on 2024/2/17.
//

import Foundation
import SwiftUtility

extension HomeViewModel {

    /// Display on the TableView
    struct Section {
        let header: String?
        let rows: [Row]
    }

    enum Row {
        case registerForm(ContentTableViewCell.Input, ContentTableViewCell.Output)
    }

    struct DataSource { 
        /// Define your data model
    }
}

class HomeViewModel {

    typealias State = UIState<[Section]>

    // MARK: - Properties

    var sections: [Section] { generateSections() }
    private(set) var data = DataSource() {
        didSet {
            dataDidUpdateClosure?(state)
        }
    }
    private(set) var state: State = .loading
    
    // MARK: - Closures

    var dataDidUpdateClosure: ((State) -> Void)?
    
    // MARK: - Constructors

    init() {
        
    }

    func loadData() {
        state = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.state = .content(self.sections)
            self.data = DataSource()
        }
    }
}

// MARK: - Private

private extension HomeViewModel {

    func generateSections() -> [Section] {
        /// Build your sections
        return [
            Section(header: nil, rows: [
                .registerForm(
                    .init(title: "Register Form", value: "An example of using VIPER architecture to build a registration form that includes input, validation, formatting, and UI components.", showIndicator: true),
                    .init()
                )
            ])
        ]
    }
}

// MARK: - TableView

extension HomeViewModel {

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
