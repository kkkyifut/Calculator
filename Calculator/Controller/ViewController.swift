import UIKit

class ViewController: UIViewController {
    private var resultField = ""
    private var resultFieldList = [String]()
    private var firstNumber = 0.0
    private var secondNumber = 0.0
    private var action = 0
    private var character = ""
    private var resulting = ""
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var lineAboveResult: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var additionalLabel: UILabel!

    @IBAction func numbers(_ sender: UIButton) {
        if answerLabel.text!.contains("=") {
            additionalLabel.text! += "\n" + answerLabel.text!
//            additionalLabel.text = "\n" + answerLabel.text!
            answerLabel.text = ""
        }
        if resultLabel.text?.first != "0" {
            resultLabel.text = resultField
            resultLabel.text! += "\(sender.tag)"
            resultField = resultLabel.text!
            
//            resultLabel.text = createEmptySpaceInNumber(String(resultField))
//            resultLabel.text = String(resultLabel.text!.reversed())
//            var formattedNumber = ""
//            for (index, character) in resultLabel.text!.enumerated() {
//                formattedNumber.append(character)
//                if index % 3 == 2 && index != resultLabel.text!.count - 1 {
//                    formattedNumber.append(" ")
//                }
//            }
//            resultLabel.text! = String(formattedNumber.reversed())
        } else {
            resultLabel.text! = "\(sender.tag)"
            resultField = resultLabel.text!
        }
        calculateResult()
    }
    
    private func createEmptySpaceInNumber(_ string: String) -> String {
        let newString = String(string.reversed())
        var formattedNumber = ""
        for (index, character) in newString.enumerated() {
            formattedNumber.append(character)
            if index % 3 == 2 && index != newString.count - 1 {
                formattedNumber.append(" ")
            }
        }
        return String(formattedNumber.reversed())
    }

    private func deleteEmptySpaceInNumber(_ string: String) -> String {
        let newString = String(string.reversed())
        var formattedNumber = ""
        for (index, character) in newString.enumerated() {
            formattedNumber.append(character)
            if index % 3 == 2 && index != newString.count - 1 {
                formattedNumber.append(" ")
            }
        }
        return String(formattedNumber.reversed())
    }
    
    private func calculateResult() {
        let actions = ["+", "-", "×", "÷", "⌃"]
        var results = [String]()
        if !resultField.isEmpty {
            if resultField.contains("+") {
                results = resultField.components(separatedBy: ["+"])
                character = "+"
            } else if resultField.contains("-") {
                results = resultField.components(separatedBy: ["-"])
                character = "-"
            } else if resultField.contains("×") {
                results = resultField.components(separatedBy: ["×"])
                character = "×"
            } else if resultField.contains("÷") {
                results = resultField.components(separatedBy: ["÷"])
                character = "÷"
            } else if resultField.contains("⌃") {
                results = resultField.components(separatedBy: ["⌃"])
                character = "⌃"
            }
            var temp = true
            results = results.map { $0.replacingOccurrences(of: " ", with: "") }
            for result in results {
                if temp {
                    if let first = Double(result) {
                        self.firstNumber = first
                        temp = false
                    }
                } else if let second = Double(result) {
                    self.secondNumber = second
                }
            }
        }
        var result = ""
        if resultField.contains("+") {
            result = String(firstNumber + secondNumber)
        } else if resultField.contains("-") {
            result = String(firstNumber - secondNumber)
        } else if resultField.contains("×") {
            result = String(firstNumber * secondNumber)
        } else if resultField.contains("÷") {
            result = String(round(firstNumber / secondNumber * 10e10) / 10.0e10)
        } else if resultField.contains("⌃") {
            result = String(pow(firstNumber, secondNumber))
        }
        let listResult = result.components(separatedBy: ["."])
        if listResult.count > 1 && listResult[1] == "0" {
            answerLabel.text = listResult[0]
            resulting = listResult[0]
        } else {
            answerLabel.text = result
            resulting = result
        }
        lineAboveResult.isHidden = false
        answerLabel.isHidden = false
        firstNumber = 0
        secondNumber = 0
    }
    
    @IBAction func actions(_ sender: UIButton) {
        action = sender.tag
        if resultLabel.text?.first == "0" { return }
        if action == 17 { // Clean All
            resultField = "0"
            resultLabel.text = "0"
            lineAboveResult.isHidden = true
            answerLabel.isHidden = true
            firstNumber = 0
            secondNumber = 0
        } else if action == 16 { // Clean 1 char
            if resultField.count <= 1 {
                resultField = "0"
                resultLabel.text = "0"
                lineAboveResult.isHidden = true
                answerLabel.isHidden = true
                return
            }
            resultField = String(Array(resultField)[..<(resultField.count - 1)])
            resultLabel.text = resultField
//            resultLabel.text = createEmptySpaceInNumber(String(resultField))
            calculateResult()
//            resultLabel.text = String(resultField.reversed())
//            var formattedNumber = ""
//            for (index, character) in resultLabel.text!.enumerated() {
//                formattedNumber.append(character)
//                if index % 3 == 2 && index != resultLabel.text!.count - 1 {
//                    formattedNumber.append(" ")
//                }
//            }
//            resultLabel.text! = String(formattedNumber.reversed())
        } else if action == 10 { // =
            if resultField.contains("=") { return }
            resultLabel.text! += " = "
            resultField += " = "
            var resulting = ""
            var resList = [Double]()
            var calculating = 0
            for char in Array(resultField) where char != " " {
                if !char.isNumber {
                    resList.append(Double(resulting)!)
                    resulting = ""
                    continue
                }
                resulting += String(char)
            }
            if resList.count < 2 {
                return
            }
            answerLabel.text = "\(resList[0]) \(character) \(resList[1]) = \(self.resulting)"
            resultField = "0"
            resultLabel.text = "0"
            
        }
        if resultField.contains("+") || resultField.contains("-") || resultField.contains("×") || resultField.contains("÷") || resultField.contains("⌃") { return }
        if action == 11 { // +
            resultLabel.text! += " + "
            resultField += " + "
        } else if action == 12 { // -
            resultLabel.text! += " - "
            resultField += " - "
        } else if action == 13 { // *
            resultLabel.text! += " × "
            resultField += " × "
        } else if action == 14 { // /
            resultLabel.text! += " ÷ "
            resultField += " ÷ "
        } else if action == 15 { // ⌃
            resultLabel.text! += " ⌃ "
            resultField += " ⌃ "
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lineAboveResult.isHidden = true
        answerLabel.isHidden = true
    }
}

