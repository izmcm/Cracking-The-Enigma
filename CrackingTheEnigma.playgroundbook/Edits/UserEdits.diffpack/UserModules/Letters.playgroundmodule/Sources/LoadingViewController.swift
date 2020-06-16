import Foundation
import UIKit

public class LoadingViewController: UIViewController {
    var loadingView = UIView()
    var loadingIndicator = UIActivityIndicatorView()
    public var isFirstText = true
    
    public override func viewDidLoad() {
        self.view.backgroundColor = AppColors.darkBlue.uiColor
        
        showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ 
            self.removeLoading()
            self.goToLetterViewController()
        }
    }
    
    func showLoading() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.center = loadingView.center
        
        loadingView.addSubview(loadingIndicator)
        self.view.addSubview(loadingView)
        
        addConstraints()
    }
    
    func removeLoading() {
        loadingIndicator.stopAnimating()
        loadingView.removeFromSuperview()
    }
    
    func goToLetterViewController() {
        var letterViewController = LetterViewController()
        letterViewController.isFirstText = isFirstText
        self.navigationController?.pushViewController(letterViewController, animated: false)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([ 
            loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0), 
            loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
        ])
    }
}
