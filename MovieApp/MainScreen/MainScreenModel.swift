
import Alamofire

protocol IMainScreenModel
{
    func loadFilms( complitionHandler: @escaping ([Movie]) -> Void)
}

final class MainScreenModel: IMainScreenModel
{
    private let netWorkProvider: IMainScreenNetworkProvider
    
    func loadFilms(complitionHandler: @escaping ([Movie]) -> Void) {
        self.netWorkProvider.loadFilms(completion: complitionHandler)
    }
    
    init(dataProvider: IMainScreenNetworkProvider) {
        self.netWorkProvider = dataProvider
    }
}

