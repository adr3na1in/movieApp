
protocol IDetailScreenPresenter
{
    func didLoad(ui: IDetailScreenView, vc: DetailScreenViewController)
}

final class DetailScreenPresenter {
    private var ui: IDetailScreenView?
    private let model: IDetailScreenModel
    private var vc: DetailScreenViewController?
    
    init(model: IDetailScreenModel) {
        self.model = model
    }
}

extension DetailScreenPresenter: IDetailScreenPresenter
{
    func didLoad(ui: IDetailScreenView, vc: DetailScreenViewController) {
        self.ui = ui
        self.vc = vc
        self.ui?.configDetailScreenView(with: self.model.movie)

    }
}
