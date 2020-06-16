import Foundation
import UIKit

protocol EnigmaDelegate {
    func runMessage()
    func cleanAllAction()
    func nextPage()
}

public class EnigmaMachineView: UIView, ViewCode {   
    var delegate: EnigmaDelegate!
    
    private var runButton = UIButton()
    private var nextButton = UIButton()
    private var cleanAllButton = UIButton()
    private var DIYButton = UIButton()
    private var firstTag = UILabel()
    public var messageGameView = UILabel()
    private var gameMessageStr = "JXRFGBWBURWAYTHXF_BFMKWSLCMHZK"
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        setupView()
    }
    
    // MARK: VARIABLES
    let textLabel: (String, UIFont.TextStyle) -> UILabel = { str, size in
        let view = UILabel()
        view.text = str
        view.font = UIFont.setSizeByStyle(style: size)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    let firstTextField: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = AppColors.white.uiColor
        view.backgroundColor = AppColors.black.uiColor
        view.layer.cornerRadius = 3
        view.font = UIFont.systemFont(ofSize: 25)
        view.isUserInteractionEnabled = false
        view.textAlignment = .center
        view.isUserInteractionEnabled = true
        view.isEditable = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let keyboard: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = AppColors.mediumBlue.uiColor
        view.layer.borderWidth = 3
        view.layer.borderColor = AppColors.white.uiColor.cgColor
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let myButton: (String, UIColor) -> UIButton = { str, color in
        let view = UIButton()
        view.setBackgroundColor(color, forState: .normal)
        view.setBackgroundColor(AppColors.black.uiColor, forState: .selected)
        view.setTitle(str, for: .normal)
        view.layer.cornerRadius = 3
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        view.layer.shadowRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    let blackView: (String) -> UILabel = { str in
        let view = UILabel()
        view.text = str 
        view.font = UIFont.setSizeByStyle(style: .title1)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.layer.borderColor = AppColors.white.uiColor.cgColor
        view.layer.borderWidth = 2
        view.backgroundColor = AppColors.veryDarkBlue.uiColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        return view
    }
    
    let blurView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: VIEW CODE
    func buildView() {
        messageGameView = blackView(gameMessageStr)
        addSubview(messageGameView)
        
        addSubview(keyboard)
        
        runButton = myButton("Run", AppColors.green.uiColor)
        addSubview(runButton)
        
        cleanAllButton = myButton("Clean all", AppColors.red.uiColor)
        addSubview(cleanAllButton)
        
        addSubview(blurView)
        
        firstTag = textLabel("Write the message above on the keyboard and click the button to see the result", .title2)
        addSubview(firstTag)
        
        nextButton = myButton("Send", AppColors.yellow.uiColor)
        addSubview(nextButton)
        
        addSubview(firstTextField)
    }
    
    func setupConstraints() {
        messageGameView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageGameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        messageGameView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        messageGameView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        
        firstTag.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        firstTag.topAnchor.constraint(equalTo: self.messageGameView.bottomAnchor, constant: 20).isActive = true
        firstTag.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
        
        firstTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        firstTextField.topAnchor.constraint(equalTo: self.firstTag.bottomAnchor, constant: 15).isActive = true
        firstTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        firstTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        runButton.rightAnchor.constraint(equalTo: self.firstTextField.rightAnchor, constant: 0).isActive = true
        runButton.topAnchor.constraint(equalTo: self.firstTextField.bottomAnchor, constant: 20).isActive = true
        runButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        runButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cleanAllButton.leftAnchor.constraint(equalTo: self.firstTextField.leftAnchor, constant: 0).isActive = true
        cleanAllButton.topAnchor.constraint(equalTo: self.firstTextField.bottomAnchor, constant: 20).isActive = true
        cleanAllButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        cleanAllButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        keyboard.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        keyboard.topAnchor.constraint(greaterThanOrEqualTo: self.runButton.bottomAnchor, constant: 30).isActive = true
        keyboard.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        keyboard.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35).isActive = true
        NSLayoutConstraint(item: keyboard, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 3/4, constant: 0).isActive = true

        blurView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        NSLayoutConstraint(item: nextButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 3/4, constant: 0).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        nextButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAdditionalConfigs() {
        self.backgroundColor = AppColors.darkBlue.uiColor
        
        blurView.isHidden = true
        blurView.alpha = 0.0
        nextButton.isHidden = true
        nextButton.alpha = 0.0
        
        runButton.addTarget(self, action: #selector(runMessage), for: .touchUpInside)
        cleanAllButton.addTarget(self, action: #selector(cleanAllAction), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }
    
    @objc func runMessage() {
        self.delegate.runMessage()
    }
    
    @objc func cleanAllAction() {
        self.delegate.cleanAllAction()
    }
    
    @objc func nextPage() {
        self.delegate.nextPage()
    }
    
    func endGame() {
        blurView.isHidden = false
        nextButton.isHidden = false
        UIView.animate(withDuration: 1.5) {
            self.blurView.alpha = 1.0
            self.nextButton.alpha = 1.0
            self.firstTag.text = "Well... I'm not sure if this is right, but I think you should send it to the captain"
        }
    }

}
