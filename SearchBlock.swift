import Foundation
import SpriteKit
class SearchBlock: SKSpriteNode{
    var labelLetter = SKLabelNode(fontNamed:"Panton")
    var number = 0
    init(color: UIColor, size: CGSize!, letter: String!, position: CGPoint!) {
        super.init(texture: nil, color: color, size: size)
        self.position = position
        if let number = Int(letter) {
            self.number = number
        }
        self.labelLetter.fontSize = size.height/1.5
        self.labelLetter.text = letter
        self.labelLetter.horizontalAlignmentMode = .center
        self.labelLetter.verticalAlignmentMode = .center
        self.labelLetter.fontColor = Helper.shared.returnColor(color: .labelFontColor)
        self.isUserInteractionEnabled = false
        self.addChild(labelLetter)
    }
    func colorize(){
        let colorize = SKAction.colorize(with: UIColor(red:0.01, green:0.47, blue:0.74, alpha:1.0), colorBlendFactor: 1, duration: 0.05)
        self.run(colorize)
    }
    func getNumber()->Int{
        return self.number
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
