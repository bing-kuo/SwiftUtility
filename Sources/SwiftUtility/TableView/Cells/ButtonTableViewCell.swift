import UIKit

public class ButtonTableViewCell: UITableViewCell {

    // MARK: - Properties

    private(set) var input: Input?
    private(set) var output: Output?

    // MARK: - UI Properties
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleButtonTouchUp), for: .touchUpInside)
        return button
    }()

    // MARK: - Constructors

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        reset()
    }
}

// MARK: - CustomTableViewCell

extension ButtonTableViewCell: CustomTableViewCell {
    
    public enum Category {
        case normal
        case dangerous
    }

    public struct Input {
        let title: String
        let category: Category
        let isEnabled: Bool
        
        public init(
            title: String,
            category: Category = .normal,
            isEnabled: Bool = true
        ) {
            self.title = title
            self.category = category
            self.isEnabled = isEnabled
        }
    }
    
    public struct Output {
        let clickActionHandler: (() -> Void)?
        
        public init(clickActionHandler: (() -> Void)? = nil) {
            self.clickActionHandler = clickActionHandler
        }
    }

    public func configure(input: Input, output: Output) {
        self.input = input
        self.output = output
        
        button.backgroundColor = .clear
        button.setTitle(input.title, for: .normal)
        button.isEnabled = input.isEnabled
        button.setTitleColor(.systemGray, for: .disabled)
        
        switch input.category {
        case .normal:
            button.setTitleColor(.systemBlue, for: .normal)
        case .dangerous:
            button.setTitleColor(.systemRed, for: .normal)
        }
    }

    public func reset() {
        input = nil
        output = nil
        button.backgroundColor = .clear
        button.isEnabled = true
        button.setTitle(nil, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .disabled)
    }
}

// MARK: - Actions

private extension ButtonTableViewCell {

    @objc func handleButtonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = .silverGray
    }
    
    @objc func handleButtonTouchUp(_ sender: UIButton) {
        guard let output else { return }
        sender.backgroundColor = UIColor.clear
        output.clickActionHandler?()
    }
}

// MARK: - Setup UI

private extension ButtonTableViewCell {

    func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(button)

        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 44)
        heightConstraint.priority = UILayoutPriority.defaultHigh

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heightConstraint
        ])
    }
}
