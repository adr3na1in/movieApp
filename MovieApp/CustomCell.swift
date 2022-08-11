
import UIKit
import SnapKit

final class CustomCell: UITableViewCell
{
    static let tag = "Custom cell"
    static let height = Metrics.height + Metrics.defaultInset * 2
    private enum Metrics {
        
        static let cornerRadius = CGFloat(16)
        static let defaultInset = CGFloat(5)
        static let height = CGFloat(120)
        static let width = CGFloat(95)
        static let titleHeight = CGFloat(18)
    }
    
    private lazy var posterView: UIImageView = {
        let obj = UIImageView()
        obj.sizeToFit()
        obj.layer.cornerRadius = Metrics.cornerRadius
        obj.backgroundColor = ColorPalette.gray
        return obj
    }()
    
    private lazy var title: UILabel = {
        let obj = UILabel()
        obj.text = "Название"
        obj.font = Fonts.poppins(type: .semi, size: .small)
        obj.textColor = .white
        return obj
    }()
    
    private lazy var titleName: UILabel = {
        let obj = UILabel()
        obj.font = Fonts.poppins(type: .semi, size: .small)
        obj.textColor = .white
        obj.numberOfLines = -1
        return obj
    }()
    
    func fillCell(with movie: Movie) {
        if let img = movie.miniPoster.img {
            self.posterView.image = img
        } else {
            self.posterView.image = movie.miniPoster.placeHolder
        }
        self.titleName.text = movie.title
        
    }
    
    func configView() {
        self.contentView.addSubview(self.posterView)
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.titleName)
        self.contentView.backgroundColor = ColorPalette.gray
        
        
        
        self.posterView.snp.makeConstraints { pin in
            pin.top.equalToSuperview().offset(Metrics.defaultInset)
            pin.left.equalToSuperview().offset(Metrics.defaultInset)
            pin.height.equalTo(Metrics.height)
            pin.width.equalTo(Metrics.width)
        }
        
        self.title.snp.makeConstraints { pin in
            pin.top.equalToSuperview().offset(Metrics.defaultInset)
            pin.left.equalTo(self.posterView.snp.right).offset(Metrics.defaultInset * 4)
            pin.height.equalTo(Metrics.titleHeight)
            pin.right.equalToSuperview().offset(-Metrics.defaultInset)
        }
        
        self.titleName.snp.makeConstraints { pin in
            pin.top.equalTo(self.title.snp.bottom).offset(Metrics.defaultInset)
            pin.left.equalTo(self.posterView.snp.right).offset(Metrics.defaultInset * 4)
            pin.height.equalTo(Metrics.titleHeight)
            pin.right.equalToSuperview().offset(-Metrics.defaultInset)
        }
        
    }
}
