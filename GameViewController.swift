import UIKit
import SpriteKit
import GameplayKit
class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            if let view = self.view as! SKView? {
                if gameMode == .maxNumber || gameMode == .minNumber {
                    let testScene = GameScene(size: view.bounds.size, scaleMode:SKSceneScaleMode.aspectFill, viewController: self)
                    testScene.viewController = self
                    testScene.size = view.bounds.size
                    testScene.scaleMode = SKSceneScaleMode.aspectFill
                    testScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    view.presentScene(testScene)
                } else {
                    let testScene = GameSceneTwo(size: view.bounds.size, scaleMode:SKSceneScaleMode.aspectFill, viewController: self)
                    testScene.viewController = self
                    testScene.size = view.bounds.size
                    testScene.scaleMode = SKSceneScaleMode.aspectFill
                    testScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    view.presentScene(testScene)
                }
            }
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
