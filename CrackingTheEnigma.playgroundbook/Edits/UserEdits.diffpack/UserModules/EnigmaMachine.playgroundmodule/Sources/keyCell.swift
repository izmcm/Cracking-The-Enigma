import UIKit
import  Foundation

class keyCell: UICollectionViewCell, ViewCode {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: VARIABLES
    let charLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: VIEW CODE
    func buildView() {
        addSubview(charLabel)
    }

    func setupConstraints() {
        charLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        charLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        charLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        charLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    func setupAdditionalConfigs() { }

}
