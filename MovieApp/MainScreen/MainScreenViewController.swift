
import UIKit
protocol IMainScreenViewController
{
    func pushNextScreen (with movie: Movie)
}

final class MainScreenViewController: UIViewController {
    private let ui = MainScreenView()
    private let presenter: IMainScreenPresenter
    
    init(presenter: IMainScreenPresenter) {
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

extension MainScreenViewController: IMainScreenViewController
{
    func pushNextScreen (with movie: Movie) {
        self.navigationController?.pushViewController(DetailScreenAssambly.makeModule(with: movie), animated: true)

    }
}
