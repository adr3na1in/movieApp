
import Alamofire
import UIKit

final class RemoteImg
{
    var img: UIImage? {
        didSet {
            if let img = self.img {
                self.didLoadHandler?(img)
            }
        }
    }
    var placeHolder: UIImage?
    
    var didLoadHandler: ((UIImage) -> Void)?
    
    init(url: String) {
        AF
            .request(url)
            .responseData { response in
                switch response.result {
                case.success(let data):
                    self.img = UIImage(data: data)
                case.failure(_):
                    break
                }
            }
    }
}
