
import Alamofire

protocol IMainScreenNetworkProvider
{
    func loadFilms(completion: @escaping (([Movie]) -> Void))
}

final class MainScreenNetworkProvider
{
    
}

extension MainScreenNetworkProvider: IMainScreenNetworkProvider
{
    func loadFilms(completion: @escaping (([Movie]) -> Void)) {
        AF
            .request("https://kinobd.ru/api/films")
            .responseJSON { response in
                switch response.result {
                case.success(let jsonAny):
                    if let movies = self.parseJson(from: jsonAny) {
                        completion(movies)
                    }
                case.failure(_):
                    break
                }
            }
    }
}

private extension MainScreenNetworkProvider
{
    func parseJson(from jsonAny: Any) -> [Movie]? {
        guard let data = jsonAny as? [String: Any] else { return nil }
        guard let filmData = data["data"] as? [[String: Any]] else { return nil }
        var movies = [Movie]()
        filmData.enumerated().forEach { index, obj in
            guard let name = obj["name_russian"] as? String else { return }
            guard let urlImg = obj["big_poster"] as? String else { return }
            guard let descript = obj["description"] as? String else { return }
            let remoteImg = RemoteImg(url: urlImg)
            movies.append(Movie(title: name, miniPoster: remoteImg, rank: 0, premierData: "", description: descript))
        }
        return movies
    }
}
