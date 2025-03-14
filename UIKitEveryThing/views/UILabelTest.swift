import UIKit

class UILabelTest: UIViewController {

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let basicLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 UILabel 입니다"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "색상이 있는 UILabel 입니다"
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let multiLineLabel: UILabel = {
        let label = UILabel()
        label.text = "여러 줄로 표시되는\nUILabel 입니다\n줄바꿈이 가능합니다"
        label.numberOfLines = 0
        return label
    }()

    private let attributedLabel: UILabel = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "UILabel 테스트"

        view.addSubview(stackView)

        [basicLabel, colorLabel, multiLineLabel, attributedLabel].forEach {
            stackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
