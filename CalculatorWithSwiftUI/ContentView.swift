//
//  ContentView.swift
//  CalculatorWithSwiftUI
//
//  Created by たまご on 2020/12/17.
//

import SwiftUI

struct ContentView: View {
    @State var result = ""
    @State var didSelectedOperator = false
    @State var calclator: Calculator = Calculator()
    let inputItem = [["9","8","7","÷"],
                    ["6","5","4","×"],
                    ["3","2","1","-"],
                    ["0","C","=","+"]]
    var body: some View {
        VStack {
            Spacer()
            Text(result)
                .font(.largeTitle)
            Spacer()
            ForEach((0...3), id: \.self) { row in
                HStack {
                    ForEach((0...3), id: \.self) { col in
                        Button(action: {
                            let currentItem = self.inputItem[row][col]

                            if isOperator(currentItem) {
                                if !didSelectedOperator {
                                    if let val = Double(self.result) {
                                        calclator.setLeftValue(val)
                                    }
                                    calclator.setOperator(currentItem)
                                    didSelectedOperator = true
                                }
                                self.result = ""
                            } else if isEqual(currentItem) {
                                // すでに演算子が選択されていた場合は右辺に数値を設定する
                                if didSelectedOperator {
                                    if let val = Double(self.result) {
                                        calclator.setRightValue(val)
                                    }
                                    didSelectedOperator = false
                                }

                                if let res = calclator.calc() {
                                    self.result = String(res)
                                } else {
                                    print("calc result is failed")
                                }
                            } else if isClear(currentItem) {
                                calclator.clear()
                                self.result = ""
                            } else {
                                result += currentItem
                            }
                        }) {
                            Spacer()
                            Text(self.inputItem[row][col])
                            Spacer()
                        }
                    }
                }
                .padding(30)
            }
        }
    }
    
    private func isOperator(_ item: String) -> Bool {
        let operatorItems = ["+", "-", "×", "÷"]
        
        return operatorItems.contains(item)
    }
    
    private func isEqual(_ item: String) -> Bool {
        return item == "="
    }
    
    private func isClear(_ item: String) -> Bool {
        return item == "C"
    }
    
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
