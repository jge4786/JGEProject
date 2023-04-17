import UIKit
import SnapKit
import Then

public class DallaViewController: UIViewController {

    var tmpView = UIView().then {
        $0.snp.makeConstraints { make in
            make.width.height.equalTo(150)
        }
        $0.backgroundColor = .red
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tmpView)
    }

}
