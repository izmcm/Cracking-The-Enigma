
import  UIKit
import  Foundation

public class PlugboadView: UIView, ViewCode {
    var plugboardSettings: [String] = ["AJ", "GH", "ZY", "OK"]
    private let answerPlugboard = ["AP", "LE", "MJ", "OK"]
    
    private var colors: [UIColor] = AppColors.plugboardColors
    
    init(size: CGRect, settings: [String]) {
        super.init(frame: size)
        self.plugboardSettings = settings
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadViewa() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        setupView()
    }
    
    let keyboardKeys = KeyboardKeys()
    var sections = [9, 8, 9, 2]
    
    func buildView() {
        let eachCellHeight = self.frame.height/CGFloat(sections.count)
        colors.shuffle()
        
        var yCount = 0
        for sec in sections {
            var eachCellWidth = self.frame.width/CGFloat(sec)
            if sec == 8 {
                let viewSize = 8*self.frame.width/9
                eachCellWidth = viewSize/CGFloat(sec)
            } else if sec == 2 {
                let viewSize = 5*self.frame.width/9
                eachCellWidth = viewSize/CGFloat(sec)
            }
            
            for i in 0..<sec {
                var xPosition = eachCellWidth*CGFloat(i)
                if sec == 8 {
                    xPosition += self.frame.width/18
                } else if sec == 2 {
                    xPosition += 4*self.frame.width/18
                }
                
                let yPosition = eachCellHeight*CGFloat(yCount)
                
                let cell = createView(x: xPosition, 
                                      y: yPosition, 
                                      width: eachCellWidth, 
                                      height: eachCellHeight)
                
                let letter = keyboardKeys.getLine(yCount)[i]
                let letterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height/2))
                letterLabel.text = letter
                letterLabel.textAlignment = .center
                
                var color = AppColors.darkBlue.uiColor
                var borderColor = AppColors.white.uiColor
                
                for idx in 0..<plugboardSettings.count {
                    let strSetting = plugboardSettings[idx]
                    
                    if strSetting.contains(letter) {
                        color = colors[idx]
                        
                        if !answerPlugboard.contains(strSetting) {
                            borderColor = AppColors.red.uiColor
                            letterLabel.textColor = borderColor
                        }
                    }
                }
                
                let plug = createPlug(x: cell.frame.width/2 - 17.5,
                                      y: cell.frame.height - 40, 
                                      width: 35,
                                      height: 25,
                                      color: color,
                                      borderColor: borderColor)
                
                cell.layer.addSublayer(plug)
                cell.addSubview(letterLabel)
                addSubview(cell)
            }
            yCount += 1
        }

    }
    
    func createPlug(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor, borderColor: UIColor) -> CAShapeLayer {
        let ellipsePath = UIBezierPath(ovalIn: CGRect(x: x, y: y, width: width, height: height))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.lineWidth = 4.0
        
        return shapeLayer
    }
    
    func createView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
        let thisFrame = CGRect(x: x,
                               y: y, 
                               width: width,
                               height: height)
        return UIView(frame: thisFrame)
    }
    
    func setupConstraints() { }
    
    func setupAdditionalConfigs() {
        self.backgroundColor = AppColors.mediumBlue.uiColor
        self.layer.cornerRadius = 3
        self.layer.borderColor = AppColors.white.uiColor.cgColor
        self.layer.borderWidth = 3
    }
    
}
