import UIKit

public class TextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private(set) var input: Input?
    private(set) var output: Output?
    
    // MARK: - UI Properties
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.spacing = UITableViewCell.defaultSpacing
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UITableViewCell.boldTitleFont
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor.red.cgColor
        textField.addDoneButtonOnKeyboard()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.delegate = self
        textField.autocapitalizationType = .none
        return textField
    }()
    
    /*
     Workaround: Setting an empty string as the label's text to ensure that the label's height is calculated correctly.
     This is necessary because UIStackView doesn't update the layout properly for labels that start with no content.
     Without this empty string, dynamically adding text to the label later might not cause the expected layout update,
     resulting in the label having a height of 0 even after setting the text.
     */
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.text = ""
        label.isHidden = true
        return label
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

extension TextFieldTableViewCell: CustomTableViewCell {
    
    public enum Category {
        case text
        case number
        case decimal
        case password
    }
    
    public struct Input {
        let title: String
        let placeholder: String?
        let text: String?
        let errorText: String?
        let category: Category
        let onValidate: ((String?) -> String?)?
        let onFormat: ((String?) -> Bool)?
        
        public init(
            title: String,
            placeholder: String? = nil,
            text: String? = nil,
            errorText: String? = nil,
            category: Category = .text,
            onValidate: ((String?) -> String?)? = nil,
            onFormat: ((String?) -> Bool)? = nil
        ) {
            self.title = title
            self.placeholder = placeholder
            self.text = text
            self.errorText = errorText
            self.category = category
            self.onValidate = onValidate
            self.onFormat = onFormat
        }
    }
    
    public struct Output {
        var textUpdatedHandler: ((String?) -> Void)?
        
        public init(textUpdatedHandler: ((String?) -> Void)? = nil) {
            self.textUpdatedHandler = textUpdatedHandler
        }
    }
    
    public func configure(input: Input, output: Output) {
        self.input = input
        self.output = output
        
        titleLabel.text = input.title
        textField.placeholder = input.placeholder
        textField.text = input.text
        
        setupErrorLabel(input.errorText)
        setup(with: input.category)
    }
    
    private func setup(with category: Category) {
        switch category {
        case .text:
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .numberPad
        case .decimal:
            textField.keyboardType = .decimalPad
        case .password:
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
        }
    }
    
    public func reset() {
        input = nil
        output = nil
        titleLabel.text = nil
        errorLabel.text = ""
        textField.placeholder = nil
        textField.text = nil
        textField.keyboardType = .default
        textField.isSecureTextEntry = false
        textField.autocorrectionType = .yes
        textField.spellCheckingType = .yes
    }
}

// MARK: - Setup UI

private extension TextFieldTableViewCell {

    func setupUI() {
        selectionStyle = .none

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UITableViewCell.defaultPadding.top),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UITableViewCell.defaultPadding.left),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UITableViewCell.defaultPadding.bottom),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UITableViewCell.defaultPadding.right)
        ])
    }
    
    func setupErrorLabel(_ text: String?) {
        errorLabel.isHidden = (text == nil)
        errorLabel.text = (text == nil) ? "" : text
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldTableViewCell: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let errorMessage = input?.onValidate?(textField.text)
        setupErrorLabel(errorMessage)
        
        output?.textUpdatedHandler?(textField.text)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let input,
            let text = textField.text,
            let textRange = Range(range, in: text),
            !string.isEmpty
        else {
            return true
        }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        guard let onFormat = input.onFormat else {
            return true
        }
        return onFormat(updatedText)
    }
}
