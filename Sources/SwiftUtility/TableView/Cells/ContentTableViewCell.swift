import UIKit

public class ContentTableViewCell: UITableViewCell {

    // MARK: - Properties

    private(set) var input: Input?
    private(set) var output: Output?

    // MARK: - UI Properties
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillProportionally
        view.axis = .horizontal
        view.spacing = UITableViewCell.defaultSpacing * 2
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.spacing = UITableViewCell.defaultSpacing
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UITableViewCell.boldTitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UITableViewCell.contentFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var indicatorContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var indicatorImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .gray
        return view
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

extension ContentTableViewCell: CustomTableViewCell {

    public struct Input {
        let title: String
        let value: String
        let showIndicator: Bool
        
        public init(title: String, value: String, showIndicator: Bool) {
            self.title = title
            self.value = value
            self.showIndicator = !showIndicator
        }
    }
    
    public struct Output {
        public init() { }
    }

    public func configure(input: Input, output: Output) {
        self.input = input
        self.output = output
        
        titleLabel.text = input.title
        contentLabel.text = input.value
        indicatorContainerView.isHidden = input.showIndicator
    }

    public func reset() {
        input = nil
        output = nil
        titleLabel.text = nil
        contentLabel.text = nil
        indicatorContainerView.isHidden = true
    }
}

// MARK: - Setup UI

private extension ContentTableViewCell {

    func setupUI() {
        selectionStyle = .none

        contentView.addSubview(hStackView)
        hStackView.addArrangedSubview(vStackView)
        hStackView.addArrangedSubview(indicatorContainerView)
        indicatorContainerView.addSubview(indicatorImageView)
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(contentLabel)

        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UITableViewCell.defaultPending.top),
            hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UITableViewCell.defaultPending.left),
            hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UITableViewCell.defaultPending.right),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UITableViewCell.defaultPending.bottom),
            
            indicatorImageView.leadingAnchor.constraint(equalTo: indicatorContainerView.leadingAnchor),
            indicatorImageView.trailingAnchor.constraint(equalTo: indicatorContainerView.trailingAnchor),
            indicatorImageView.centerYAnchor.constraint(equalTo: indicatorContainerView.centerYAnchor),
            indicatorImageView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
}
