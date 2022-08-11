
import UIKit

enum DetailScreenAssambly {
    
    static func makeModule(with movie: Movie) -> UIViewController {
        
        let model = DetailScreenModel(movie: movie)
        let presenter = DetailScreenPresenter(model: model)
        let vc = DetailScreenViewController(presenter: presenter)
        return vc
    }
}
