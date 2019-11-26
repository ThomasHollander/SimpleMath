import SpriteKit
import GameplayKit
import Flurry_iOS_SDK
class GameSceneTwo: SKScene {
    var arrayNodes: [SearchBlock] = []
    var blockCount = 0
    var array: [Int] = []
    var screenArray: [Int] = []
    var attempt = 0
    var blockSize = 0
    let titleLabel = SKLabelNode(fontNamed:"Panton")
    var viewController: GameViewController
    var answer = 0
    init(size:CGSize, scaleMode:SKSceneScaleMode, viewController: GameViewController) {
        self.viewController = viewController
        super.init(size:size)
        self.scaleMode = scaleMode
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMove(to view: SKView) {
        initBackground()
        addLabel()
        generate()
        addButton()
    }
    func toMainMenu(){
        Flurry.logEvent("main menu", withParameters: ["Level ": gameMode.rawValue]);
        self.viewController.performSegue(withIdentifier: "toMainMenu", sender: nil)
        self.scene?.removeAllChildren()
        self.scene?.removeAllActions()
    }
    func addButton(){
        var name = ""
        if let local = Locale.current.languageCode {
            if local == "ru" {
                name = "Главное меню"
            } else {
                name = "Main menu"
            }
        } else {
            name = "Main menu"
        }
        let button = ButtonClass(color: Helper().returnColor(color: .backgroundColor),
                                 size: CGSize(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/8),
                                 letter: name,
                                 position: CGPoint(x: 0, y: -UIScreen.main.bounds.height/2.5))
        self.addChild(button)
    }
    func randomTwo()->(Int,Int){
        var first = Int.random(in: 0...20)
        var second = Int.random(in: 0...20)
        while (first + second > 20) {
            first = Int.random(in: 0...20)
            second = Int.random(in: 0...20)
        }
        return (first,second)
    }
    func randomTwoSecond()->(Int,Int){
        var first = Int.random(in: 0...20)
        var second = Int.random(in: 0...20)
        while (first - second < 0) {
            first = Int.random(in: 0...20)
            second = Int.random(in: 0...20)
        }
        return (first,second)
    }
    func generateRandom(size: Int) -> [Int] {
        guard size > 0 else {
            return [Int]()
        }
        return Array(0..<20).shuffled()
    }
    func animateNodes(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            self.addChild(node)
            let animation1 = SKAction.scale(to: 1.5, duration: 0.2)
            animation1.timingMode = .easeOut
            let animation2 = SKAction.scale(to: 1, duration: 0.2)
            animation2.timingMode = .easeIn
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.1),
                .repeat(.sequence([
                    animation1,
                    animation2,
                    .wait(forDuration: 0)
                    ]), count: 1)
                ]))
        }
    }
    func createBlocks(){
        blockCount = Int.random(in: 3 ..< 7) + 1
        attempt = blockCount
        array = generateRandom(size: blockCount)
        blockSize = Int(UIScreen.main.bounds.width)/blockCount
        blockSize = Int(UIScreen.main.bounds.width-CGFloat(blockSize))/blockCount
        var sizePlus = 0
        if blockCount % 2 == 0 {
            sizePlus = blockSize*((blockCount+2)/2)-blockSize/2
        } else {
            sizePlus = blockSize*((blockCount+2)/2)
        }
        var flag = true
        for i in 1...blockCount-1{
            let block = SearchBlock(color: Helper.shared.returnColor(color: .blockColor),
                                    size: CGSize(width: blockSize-blockSize/10, height: blockSize-blockSize/10),
                                    letter: String(array[i]),
                                    position: CGPoint(x: blockSize*i-sizePlus, y: Int(-UIScreen.main.bounds.height/15)))
            arrayNodes.append(block)
            screenArray.append(array[i])
            if array[i] == answer {
                flag = false
            }
        }
        if flag {
            let block = SearchBlock(color: Helper.shared.returnColor(color: .blockColor),
                                    size: CGSize(width: blockSize-blockSize/10, height: blockSize-blockSize/10),
                                    letter: String(answer),
                                    position: CGPoint(x: blockSize*blockCount-sizePlus, y: Int(-UIScreen.main.bounds.height/15)))
            arrayNodes.append(block)
            screenArray.append(answer)
        } else {
            let block = SearchBlock(color: Helper.shared.returnColor(color: .blockColor),
                                    size: CGSize(width: blockSize-blockSize/10, height: blockSize-blockSize/10),
                                    letter: String(0),
                                    position: CGPoint(x: blockSize*blockCount-sizePlus, y: Int(-UIScreen.main.bounds.height/15)))
            arrayNodes.append(block)
            screenArray.append(answer)
        }
        animateNodes(arrayNodes)
    }
    func generate(){
        if gameMode == .exercise || gameMode == .square {
            if let local = Locale.current.languageCode {
                if local == "ru" {
                    titleLabel.text = "Сколько будет "
                } else {
                    titleLabel.text = "How many  "
                }
            } else {
                titleLabel.text = "How many  "
            }
        }
        if gameMode == .exercise {
            let (first, second) = randomTwo()
            titleLabel.text = titleLabel.text! + String(first)
            titleLabel.text = titleLabel.text! + "+" + String(second) + "?"
            answer = first + second
        } else if gameMode == .square {
            let (first, second) = randomTwoSecond()
            titleLabel.text = titleLabel.text! + String(first)
            titleLabel.text = titleLabel.text! + "−" + String(second) + "?"
            answer = first - second
        }
        createBlocks()
    }
    func animateTitleLabel(color: UIColor, wait: Double){
        let animation1 = SKAction.colorize(with: color, colorBlendFactor: 1.0, duration: 0.2)
        animation1.timingMode = .easeOut
        let animation2 = SKAction.colorize(with: Helper().returnColor(color: .blockColor), colorBlendFactor: 0.0, duration: 0.2)
        animation2.timingMode = .easeIn
        titleLabel.run(.sequence([
            animation1,
            .wait(forDuration: wait),
            animation2
            ]))
    }
    func checkAnswer(number: Int, node: SearchBlock){
        if number == answer {
            Flurry.logEvent("Good attempt", withParameters: ["Level ": gameMode.rawValue]);
            animateTitleLabel(color: UIColor.green, wait: 0.6)
            array.removeAll()
            screenArray.removeAll()
            for block in arrayNodes {
                block.removeAllActions()
                block.removeFromParent()
            }
            arrayNodes.removeAll()
            generate()
        } else {
            Flurry.logEvent("Bad attempt", withParameters: ["Level ": gameMode.rawValue]);
            animateTitleLabel(color: UIColor.red, wait: 0.2)
            attempt = attempt + 1
            let position = node.position
            if let index = arrayNodes.index(of: node) {
                arrayNodes.remove(at: index)
                screenArray.remove(at: index)
            }
            node.removeAllActions()
            node.removeFromParent()
            var number = "0"
            if attempt+blockCount <= 20 {
                number = String(array[attempt])
            } else {
                attempt = 0
            }
            if number == String(answer) {
                number = "0"
            }
            let block = SearchBlock(color: Helper.shared.returnColor(color: .blockColor),
                                    size: CGSize(width: blockSize-blockSize/10, height: blockSize-blockSize/10),
                                    letter: number,
                                    position: position)
            arrayNodes.append(block)
            screenArray.append(Int(number)!)
            self.addChild(block)
            block.run(.sequence([
                .repeat(.sequence([
                    .scale(to: 1.5, duration: 0.2),
                    .scale(to: 1, duration: 0.2),
                    .wait(forDuration: 0)
                    ]), count: 1)
                ]))
        }
    }
    func addLabel(){
        titleLabel.position = CGPoint(x: 0, y: Int(UIScreen.main.bounds.height/5))
        titleLabel.fontSize = UIScreen.main.bounds.height/11
        titleLabel.horizontalAlignmentMode = .center
        titleLabel.verticalAlignmentMode = .center
        titleLabel.fontColor = Helper.shared.returnColor(color: .labelFontColor)
        self.addChild(titleLabel)
    }
    func initBackground(){
        let background = SKSpriteNode.init(texture: nil)
        background.position = CGPoint(x: 0, y: 0)
        background.color = Helper.shared.returnColor(color: .backgroundColor)
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.zPosition = -1
        background.name = "background"
        self.addChild(background)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.location(in: self.scene!)
            let touchedNode = self.atPoint(positionInScene)
            if let touchedNode = touchedNode as? SearchBlock {
                touchedNode.colorize()
                checkAnswer(number: touchedNode.getNumber(), node: touchedNode)
            } else if let touchedNode = touchedNode.parent as? SearchBlock {
                touchedNode.colorize()
                checkAnswer(number: touchedNode.getNumber(), node: touchedNode)
            } else if let   touchedNode = touchedNode as? ButtonClass {
                toMainMenu()
            } else if let touchedNode = touchedNode.parent as? ButtonClass {
                toMainMenu()
            }
        }
    }
}
