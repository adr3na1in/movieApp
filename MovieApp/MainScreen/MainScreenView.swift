
import SnapKit
import UIKit

protocol IMainScreenView
{
    func reloadTable()
    func configView()
    var cellCountHandler: (() -> Int)? { get set }
    var getMovieHandler: ((Int) -> Movie?)? { get set }
    var pressedCellHandler: ((Int) -> Void)? { get set }
}

final class MainScreenView: UIView
{
    private enum Metrics
    {
        static let defaultIndentX = CGFloat(30)
        static let topIndent = CGFloat(20)
        static let cornerRadius = CGFloat(16)
        static let bottomIndent = CGFloat(30)
        static let defaultHeight = CGFloat(42)
    }
    
    var cellCountHandler: (() -> Int)?
    var getMovieHandler: ((Int) -> Movie?)?
    var pressedCellHandler: ((Int) -> Void)?
    //MARK: - Вьюхи
    private lazy var tableView: UITableView = {
        let obj = UITableView()
        obj.register(CustomCell.self, forCellReuseIdentifier: CustomCell.tag)
        obj.delegate = self
        obj.dataSource = self
        obj.backgroundColor = ColorPalette.lightGray
        return obj
    }()
    
    private lazy var mainLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Movie DB"
        obj.font = Fonts.poppins(type: .bold, size: .large )
        obj.textColor = .white
        return obj
    }()
    
    private lazy var findMoviesLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Поиск фильмов и сериалов"
        obj.font = Fonts.poppins(type: .semi, size: .medium)
        obj.textColor = .white
        return obj
    }()
    
    private lazy var searchField: UITextField = {
        let obj = UITextField()
        obj.attributedPlaceholder = NSAttributedString(
            string: "   Введите название . . . ",
            attributes: [
                .font : Fonts.poppins(type: .extraLight, size: .semiMedium),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            
        )
        obj.backgroundColor = ColorPalette.lightGray
        obj.layer.cornerRadius = Metrics.cornerRadius
        obj.textColor = .white
        return obj
    }()
    
    private lazy var searchButton: UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(named: "Vector"), for: .normal)
        obj.imageView?.sizeToFit()
        obj.backgroundColor = ColorPalette.lightGray
        obj.layer.cornerRadius = Metrics.cornerRadius
        return obj
    }()
    
    private lazy var categoryLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Категории фильмов"
        obj.font = Fonts.poppins(type: .semi, size: .medium)
        obj.textColor = .white
        return obj
    }()
    
    
    private lazy var topRatedButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Топ рейтинга", for: .normal)
        obj.titleLabel?.font = Fonts.poppins(type: .semi, size: .small)
        obj.backgroundColor = ColorPalette.lightGray
        obj.layer.cornerRadius = Metrics.cornerRadius
        return obj
    }()
    
    private lazy var popularButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Популярное", for: .normal)
        obj.titleLabel?.font = Fonts.poppins(type: .semi, size: .small)
        obj.backgroundColor = ColorPalette.lightGray
        obj.layer.cornerRadius = Metrics.cornerRadius
        return obj
    }()
    
    private lazy var actionButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Боевики", for: .normal)
        obj.titleLabel?.font = Fonts.poppins(type: .semi, size: .small)
        obj.backgroundColor = ColorPalette.lightGray
        obj.layer.cornerRadius = Metrics.cornerRadius
        return obj
    }()
    
    private lazy var loadMoreButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Загрузить еще", for: .normal)
        obj.contentHorizontalAlignment = .left
        obj.titleLabel?.font = Fonts.poppins(type: .semi, size: .medium)
        obj.backgroundColor = ColorPalette.gray
        return obj
    }()
    
    private lazy var watchListButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Закладки", for: .normal)
        obj.setImage(UIImage(named: "bookmark"), for: .normal)
        obj.imageEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        obj.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        obj.titleLabel?.font = Fonts.poppins(type: .semi, size: .semiMedium)
        obj.setTitleColor(ColorPalette.gray, for: .normal)
        obj.backgroundColor = ColorPalette.green
        obj.layer.cornerRadius = Metrics.cornerRadius
        return obj
    }()
}

extension MainScreenView: IMainScreenView
{
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    func configView() {
        self.backgroundColor = ColorPalette.gray
        self.addSub()
        self.makeConst()
    }
    
}

extension MainScreenView: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cellCountHandler?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.tag, for: indexPath) as? CustomCell else { return UITableViewCell() }
        cell.configView()
        if let movie = self.getMovieHandler?(indexPath.row) {
            cell.fillCell(with: movie)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CustomCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pressedCellHandler?(indexPath.row)
    }
}

private extension MainScreenView
{
    func makeConst() {
        self.mainLabel.snp.makeConstraints { pin in
            pin.left.equalToSuperview().offset(Metrics.defaultIndentX)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX)
            pin.top.equalToSuperview().offset(50)
            pin.height.equalTo(54)
        }
        
        self.findMoviesLabel.snp.makeConstraints { pin in
            pin.left.equalToSuperview().offset(Metrics.defaultIndentX)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX)
            pin.top.equalTo(mainLabel.snp.bottom).offset(Metrics.topIndent)
            pin.height.equalTo(27)
        }
        
        self.searchField.snp.makeConstraints { pin in
            pin.left.equalToSuperview().offset(Metrics.defaultIndentX)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX * 3)
            pin.height.equalTo(Metrics.defaultHeight)
            pin.top.equalTo(findMoviesLabel.snp.bottom).offset(Metrics.topIndent * 1.3)
        }
        
        self.searchButton.snp.makeConstraints { pin in
            pin.width.equalTo(Metrics.defaultHeight)
            pin.height.equalTo(Metrics.defaultHeight)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX)
            pin.bottom.equalTo(searchField)
        }
        
        self.categoryLabel.snp.makeConstraints { pin in
            pin.left.equalToSuperview().offset(Metrics.defaultIndentX)
            pin.top.equalTo(searchField.snp.bottom).offset(Metrics.topIndent)
            pin.height.equalTo(Metrics.topIndent)
        }
        
        self.topRatedButton.snp.makeConstraints { pin in
            pin.left.equalToSuperview().offset(Metrics.defaultIndentX)
            pin.top.equalTo(categoryLabel.snp.bottom).offset(Metrics.topIndent)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX * 8)
            pin.height.equalTo(Metrics.defaultHeight * 0.8)
        }
        
        self.popularButton.snp.makeConstraints { pin in
            pin.left.equalTo(topRatedButton.snp.right).offset(Metrics.defaultIndentX * 0.5)
            pin.top.equalTo(categoryLabel.snp.bottom).offset(Metrics.topIndent)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX * 5)
            pin.height.equalTo(Metrics.defaultHeight * 0.8)
        }
        
        self.actionButton.snp.makeConstraints { pin in
            pin.left.equalTo(popularButton.snp.right).offset(Metrics.defaultIndentX * 0.5)
            pin.top.equalTo(categoryLabel.snp.bottom).offset(Metrics.topIndent)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX * 1.5)
            pin.height.equalTo(Metrics.defaultHeight * 0.8)
        }
        
        self.loadMoreButton.snp.makeConstraints { pin in
            pin.left.equalToSuperview().offset(Metrics.defaultIndentX)
            pin.bottom.equalToSuperview().offset(-38)
            pin.width.equalTo(172)
            pin.height.equalTo(27)
        }
        
        self.watchListButton.snp.makeConstraints { pin in
            pin.left.equalTo(loadMoreButton.snp.right).offset(11)
            pin.width.equalTo(134)
            pin.height.equalTo(Metrics.defaultHeight)
            pin.bottom.equalToSuperview().offset(-31)
        }
        
        self.tableView.snp.makeConstraints { pin in
            pin.top.equalTo(topRatedButton.snp.bottom).offset(Metrics.defaultIndentX)
            pin.left.equalToSuperview().offset(Metrics.defaultIndentX)
            pin.right.equalToSuperview().offset(-Metrics.defaultIndentX)
            pin.bottom.equalTo(watchListButton.snp.top).offset(-Metrics.defaultIndentX)
        }
    }
    
    func addSub() {
        self.addSubview(self.tableView)
        self.addSubview(self.mainLabel)
        self.addSubview(self.findMoviesLabel)
        self.addSubview(self.searchField)
        self.addSubview(self.searchButton)
        self.addSubview(self.categoryLabel)
        self.addSubview(self.topRatedButton)
        self.addSubview(self.popularButton)
        self.addSubview(self.actionButton)
        self.addSubview(self.loadMoreButton)
        self.addSubview(self.watchListButton)
    }
}
