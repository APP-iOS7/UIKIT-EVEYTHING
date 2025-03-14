import UIKit

class UILabelView: UIView {

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private(set) var basicLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 UILabel 입니다"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private(set) var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "색상이 있는 UILabel 입니다"
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private(set) var multiLineLabel: UILabel = {
        let label = UILabel()
        label.text = "여러 줄로 표시되는\nUILabel 입니다\n줄바꿈이 가능합니다"
        label.numberOfLines = 0
        return label
    }()

    private(set) var attributedLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "속성이 다른 텍스트입니다")
        attributedString.addAttribute(
            .foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 3))
        attributedString.addAttribute(
            .backgroundColor, value: UIColor.yellow, range: NSRange(location: 4, length: 3))
        attributedString.addAttribute(
            .underlineStyle, value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 8, length: 3))
        label.attributedText = attributedString
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .systemBackground

        addSubview(stackView)

        [basicLabel, colorLabel, multiLineLabel, attributedLabel].forEach {
            stackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
