import Foundation
import UIKit
import Hero
import Flurry_iOS_SDK
class MainMenuVC: UIViewController {
    @IBOutlet weak var maxNumber: UIView!
    @IBOutlet weak var minNumber: UIView!
    @IBOutlet weak var exercise: UIView!
    @IBOutlet weak var square: UIView!
    @IBOutlet weak var maxNumberLabel: UILabel!
    @IBOutlet weak var minNumberLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var squareLabel: UILabel!
    var smallestFontSize: CGFloat = 0.0
    override func viewWillAppear(_ animated: Bool) {
        let fontSize1 = maxNumberLabel.getFontSizeForLabel()
        let fontSize2 = minNumberLabel.getFontSizeForLabel()
        let fontSize3 = exerciseLabel.getFontSizeForLabel()
        let fontSize4 = squareLabel.getFontSizeForLabel()
        smallestFontSize = min(min(fontSize1, fontSize2), min(fontSize3, fontSize4))
        maxNumberLabel.adjustsFontSizeToFitWidth = false
        minNumberLabel.adjustsFontSizeToFitWidth = false
        exerciseLabel.adjustsFontSizeToFitWidth = false
        squareLabel.adjustsFontSizeToFitWidth = false
        maxNumberLabel.font = maxNumberLabel.font.withSize(smallestFontSize/3.2)
        minNumberLabel.font = minNumberLabel.font.withSize(smallestFontSize/3.2)
        exerciseLabel.font = exerciseLabel.font.withSize(smallestFontSize/3.2)
        squareLabel.font = squareLabel.font.withSize(smallestFontSize/3.2)
    }
    func addGesture(){
        maxNumber.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.maxNumberAction)))
        minNumber.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.minNumberAction)))
        exercise.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.exerciseAction)))
        square.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.squareAction)))
    }
    func viewController(forStoryboardName: String) -> UIViewController {
        return UIStoryboard(name: forStoryboardName, bundle: nil).instantiateInitialViewController()!
    }
    @objc func maxNumberAction(_ sender: UITapGestureRecognizer){
        Flurry.logEvent("To game", withParameters: ["Level ": gameMode.rawValue]);
        gameMode = .maxNumber
        let greenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.heroModalAnimationType = .fade
        self.heroReplaceViewController(with: greenVC)
    }
    @objc func minNumberAction(_ sender: UITapGestureRecognizer){
        Flurry.logEvent("To game", withParameters: ["Level ": gameMode.rawValue]);
        gameMode = .minNumber
        self.performSegue(withIdentifier: "toGameViewController", sender: nil)
    }
    @objc func exerciseAction(_ sender: UITapGestureRecognizer){
        Flurry.logEvent("To game", withParameters: ["Level ": gameMode.rawValue]);
        gameMode = .exercise
        self.performSegue(withIdentifier: "toGameViewController", sender: nil)
    }
    @objc func squareAction(_ sender: UITapGestureRecognizer){
        Flurry.logEvent("To game", withParameters: ["Level ": gameMode.rawValue]);
        gameMode = .square
        self.performSegue(withIdentifier: "toGameViewController", sender: nil)
    }
    override func viewDidLoad() {
        addGesture()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension UILabel {
    func getFontSizeForLabel() -> CGFloat {
        let text: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        text.setAttributes([NSAttributedString.Key.font: self.font], range: NSMakeRange(0, text.length))
        let context: NSStringDrawingContext = NSStringDrawingContext()
        context.minimumScaleFactor = self.minimumScaleFactor
        text.boundingRect(with: self.frame.size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = self.font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }
}
