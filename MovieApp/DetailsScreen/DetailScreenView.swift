
import UIKit
import SnapKit

protocol IDetailScreenView
{
    func configDetailScreenView(with movie: Movie)
}

final class DetailScreenView: UIView
{
    private enum Metrics {
        
        static let cornerRadius = CGFloat(16)
        static let defaultInset = CGFloat(5)
        static let height = CGFloat(120)
        static let width = CGFloat(95)
        static let titleHeight = CGFloat(18)
    }
    
    private lazy var bigPoster: UIImageView = {
        let recognizerSecondPressed = UILongPressGestureRecognizer(target: self, action: #selector(posterSecondPressed(_:)))
        recognizerSecondPressed.minimumPressDuration = 0

        let obj = UIImageView()
        obj.isUserInteractionEnabled = true
        obj.layer.cornerRadius = Metrics.cornerRadius
        obj.backgroundColor = .white
        obj.alpha = 0
        obj.sizeToFit()
        obj.addGestureRecognizer(recognizerSecondPressed)
        return obj
    }()
    
    private lazy var poster: UIImageView = {
        let recognizerPressed = UILongPressGestureRecognizer(target: self, action: #selector(posterPressed(_:)))
        recognizerPressed.minimumPressDuration = 0
        let obj = UIImageView()
        obj.isUserInteractionEnabled = true
        obj.layer.cornerRadius = Metrics.cornerRadius
        obj.backgroundColor = .white
        obj.sizeToFit()
        obj.addGestureRecognizer(recognizerPressed)
        
        
        return obj
    }()
    
    private lazy var movieName: UILabel = {
        let obj = UILabel()
        obj.font = Fonts.poppins(type: .semi, size: .small)
        obj.textColor = .white
        obj.numberOfLines = -1
        return obj
    }()
    
    private lazy var descriptionMovie: UILabel = {
        let obj = UILabel()
        obj.font = Fonts.poppins(type: .semi, size: .small)
        obj.textColor = .white
        obj.numberOfLines = -1
        return obj
    }()
    
    
    
}

private extension DetailScreenView
{
    @objc func  posterPressed(_ recognizer: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.1, delay: 0.5) {
            self.bigPoster.alpha = 1
        }
    }
    
    @objc func  posterSecondPressed(_ recognizer: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.1, delay: 0.5) {
            self.bigPoster.alpha = 0
        }
    }
}


extension DetailScreenView: IDetailScreenView
{
    func configDetailScreenView(with movie: Movie) {
        self.backgroundColor = ColorPalette.gray
        
        self.addSubview(self.poster)
        self.addSubview(self.movieName)
        self.addSubview(self.descriptionMovie)
        self.addSubview(self.bigPoster)
        
        self.bigPoster.image = movie.miniPoster.img
        self.poster.image = movie.miniPoster.img
        self.movieName.text = movie.title
        self.descriptionMovie.text = movie.description
        
        self.bigPoster.snp.makeConstraints { pin in
            pin.edges.equalToSuperview()
            
        }
        
        
        self.poster.snp.makeConstraints { pin in
            pin.top.equalToSuperview().offset(Metrics.height)
            pin.left.equalToSuperview().offset(Metrics.titleHeight)
            pin.height.equalTo(Metrics.height)
            pin.width.equalTo(Metrics.width)
        }
        
        self.movieName.snp.makeConstraints { pin in
            pin.left.equalTo(self.poster.snp.right).offset(Metrics.titleHeight)
            pin.right.equalToSuperview().offset(-Metrics.titleHeight)
            pin.top.equalTo(self.poster)
            pin.bottom.equalTo(self.poster)
        }
        
        self.descriptionMovie.snp.makeConstraints { pin in
            pin.left.equalToSuperview().offset(Metrics.titleHeight)
            pin.right.equalToSuperview().offset(-Metrics.titleHeight)
            pin.top.equalTo(self.poster.snp.bottom).offset(Metrics.titleHeight)
            pin.bottom.equalToSuperview().offset(-Metrics.titleHeight)
        }
    }
}
