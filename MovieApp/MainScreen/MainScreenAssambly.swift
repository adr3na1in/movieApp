
import UIKit

final class MainScreenAssambly {
    
    static func buildScreen() -> UIViewController {
      
        
        let dataProvider = MainScreenNetworkProvider()
        let model = MainScreenModel(dataProvider: dataProvider)
        let presenter = MainScreenPresenter(model: model)
        let vc = MainScreenViewController(presenter: presenter)
        return vc
    }
}
