import UIKit

class UILabelViewController: UIViewController {

    private let mainView = UILabelView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationItem.title = "UILabel 테스트"
        self.view = mainView
    }
}
