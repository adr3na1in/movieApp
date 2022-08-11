

import UIKit

protocol IMainScreenPresenter
{
    func didLoad(ui: IMainScreenView, vc: IMainScreenViewController)
}

final class MainScreenPresenter {
    private var ui: IMainScreenView?
    private let model: MainScreenModel
    private var movies = [Movie]()
    private var vc: IMainScreenViewController?
    
    init(model: MainScreenModel) {
        self.model = model
    }
}

extension MainScreenPresenter: IMainScreenPresenter
{
    func didLoad(ui: IMainScreenView, vc: IMainScreenViewController) {
        self.ui = ui
        self.vc = vc
        
        self.ui?.cellCountHandler = { [weak self] in
            self?.movies.count ?? 0
        }
        self.ui?.pressedCellHandler = { [weak self] index in
            if let movie = self?.movies[index] {
                self?.vc?.pushNextScreen(with: movie)
            }
        }
        self.ui?.getMovieHandler = { [weak self] index in
            self?.movies[index]
        }
        let complitionFilmHandler: ([Movie]) -> Void = { [weak self] movies in
            movies.forEach { movie in
                movie.miniPoster.didLoadHandler = { [weak self] img in
                    self?.ui?.reloadTable()
                }
            }
            self?.movies = movies
            self?.ui?.reloadTable()
            
        }
        
        self.ui?.configView()
        self.model.loadFilms(complitionHandler: complitionFilmHandler)
    }
}


