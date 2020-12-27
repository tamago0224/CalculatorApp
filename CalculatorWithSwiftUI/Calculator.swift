//
//  Calculator.swift
//  CalculatorWithSwiftUI
//
//  Created by たまご on 2020/12/20.
//

import Foundation

struct Calculator {
    var rightVal: Double? = nil
    var leftVal: Double? = nil
    // 初期状態は計算種別が選択されていないことを表す.noneを初期値に持つ
    var operatorVal: Operator? = nil
    
    // 計算状態をクリアする
    mutating func clear() {
        self.rightVal = nil
        self.leftVal = nil
        self.operatorVal = nil
    }

    mutating func setRightValue(_ val: Double) {
        self.rightVal = val
    }

    mutating func setLeftValue(_ val: Double) {
        self.leftVal = val
    }

    mutating func setOperator(_ val: String) {
        self.operatorVal = Operator(rawValue: val)
    }

    // 保存された値が右辺、左辺保持していれば計算する
    func calc() -> Double? {
        guard let left = self.leftVal else {
            return nil
        }

        guard let right = self.rightVal else {
            return nil
        }

        guard let ope = self.operatorVal else {
            return nil
        }

        return calc(right: right, left: left, ope: ope)
    }

    private func calc(right rightVal: Double, left leftVal: Double, ope opeVal: Operator) -> Double {
        switch opeVal {
        case .plus:
            return leftVal + rightVal
        case .minus:
            return leftVal - rightVal
        case .multi:
            return leftVal * rightVal
        case .divide:
            return leftVal / rightVal
        }
    }

    private func isOperator(_ ope: String) -> Bool {
        guard let _ =  Operator(rawValue: ope) else {
            return false
        }
        
        return true
    }

    enum Operator: String{
        case plus
        case minus
        case multi
        case divide

        init?(rawValue value: String) {
            switch value {
            case "+":
                self = .plus
            case "-":
                self = .minus
            case "×":
                self = .multi
            case "÷":
                self = .divide
            default:
                return nil
            }
        }
        
        var toString: String? {
            switch self {
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .multi:
                return "×"
            case .divide:
                return "÷"
            }
        }
    }
}
