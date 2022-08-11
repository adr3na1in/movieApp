

import UIKit

final class DetailScreenViewController: UIViewController {
    private let ui = DetailScreenView()
    private let presenter: IDetailScreenPresenter
    
    init(presenter: IDetailScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad(ui: self.ui, vc: self)
    }
}
