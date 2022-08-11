
protocol IDetailScreenModel
{
    var movie: Movie { get }
}

final class DetailScreenModel: IDetailScreenModel
{
    let movie: Movie
    
    init(movie: Movie)
    {
        self.movie = movie
    }
}
