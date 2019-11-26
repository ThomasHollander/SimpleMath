import Foundation
import UIKit
import SpriteKit
class ButtonClass: SKSpriteNode{
    var labelLetter = SKLabelNode(fontNamed:"Panton")
    init(color: UIColor, size: CGSize!, letter: String!, position: CGPoint!) {
        super.init(texture: nil, color: color, size: size)
        self.position = position
        self.size = size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 10
        self.isUserInteractionEnabled = true
        switch gameMode {
        case .maxNumber:
            self.labelLetter.fontSize = size.height/3
        case .minNumber:
            self.labelLetter.fontSize = size.height/3.5
        case .exercise:
            self.labelLetter.fontSize = size.height/3
        case .square:
            self.labelLetter.fontSize = size.height/3
        }
        self.labelLetter.text = letter
        self.labelLetter.horizontalAlignmentMode = .center
        self.labelLetter.verticalAlignmentMode = .center
        self.labelLetter.fontColor = Helper.shared.returnColor(color: .labelFontColor)
        self.isUserInteractionEnabled = false
        self.addChild(labelLetter)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
