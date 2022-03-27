//
//  BubbleSortStrategy.swift
//  SortingStrategy
//
//  Created by Nino on 3/27/22.
//

class BubbleSortStrategy: SortStrategy {
    func sort(_ string: String) -> String {
        
        if (string.isEmpty) { return "" }
        
        var dataSet = string.map { String($0) }
        
        let last_position = dataSet.count - 1
        var swap = true
        while swap == true {
            swap = false
            for i in 0..<last_position {
                if dataSet[i] > dataSet[i + 1] {
                    let temp = dataSet [i + 1]
                    dataSet [i + 1] = dataSet[i]
                    dataSet[i] = temp
                    
                    swap = true
                }
            }
        }
        
        return dataSet.joined()
    }
}
