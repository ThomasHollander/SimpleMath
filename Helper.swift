import Foundation
import SpriteKit
var gameMode: gameModeEnum = .maxNumber
enum gameModeEnum: String {
    case maxNumber = "Максимальное число"
    case minNumber = "Минимальное число"
    case exercise = "Сложение"
    case square = "Вычитание"
}
public class Helper {
    static let shared = Helper()
    enum colorEnum: Int {
        case backgroundColor = 0
        case blockColor = 1
        case labelFontColor = 2
        case notificationColor = 3
    }
    struct colorStruct {
        let backgroundColorMaxNumber = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0) 
        let blockColorMaxNumber = UIColor(red:0.20, green:0.56, blue:0.87, alpha:1.0) 
        let blockColorMinNumber = UIColor(red:0.18, green:0.75, blue:0.28, alpha:1.0) 
        let blockColorExercise = UIColor(red:1.00, green:0.49, blue:0.22, alpha:1.0) 
        let blockColorSquare = UIColor(red:0.66, green:0.18, blue:0.99, alpha:1.0) 
        let labelFontColor = UIColor.white
        let notificationColor = UIColor(red:0.46, green:0.64, blue:0.12, alpha:1.0)
    }
    func returnColor(color: colorEnum)->UIColor{
        switch color {
        case .backgroundColor:
            switch gameMode {
            case .maxNumber:
                return colorStruct().backgroundColorMaxNumber
            case .minNumber:
                return colorStruct().backgroundColorMaxNumber
            case .exercise:
                return colorStruct().backgroundColorMaxNumber
            case .square:
                return colorStruct().backgroundColorMaxNumber
            }
        case .blockColor:
            switch gameMode {
            case .maxNumber:
                return colorStruct().blockColorMaxNumber
            case .minNumber:
                return colorStruct().blockColorMinNumber
            case .exercise:
                return colorStruct().blockColorExercise
            case .square:
                return colorStruct().blockColorSquare
            }
        case .labelFontColor:
            return colorStruct().labelFontColor
        case .notificationColor:
            return colorStruct().notificationColor
        }
    }
}
