import UIKit

public protocol CustomTableViewCell: UITableViewCell {
    
    associatedtype Input
    associatedtype Output
    
    func configure(input: Input, output: Output)
    func reset()
}

public extension UITableView {
    
    func registerDefaultCustomTableViewCell() {
        let cellTypes: [UITableViewCell.Type] = [
            ContentTableViewCell.self,
            ButtonTableViewCell.self,
            TextFieldTableViewCell.self
        ]
        
        for cellType in cellTypes {
            register(cellType, forCellReuseIdentifier: cellType.identifier)
        }
    }
}
