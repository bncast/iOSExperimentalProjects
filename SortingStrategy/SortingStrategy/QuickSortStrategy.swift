//
//  QuickSortStrategy.swift
//  SortingStrategy
//
//  Created by Nino on 3/27/22.
//

class QuickSortStrategy: SortStrategy {
    func sort(_ string: String) -> String {
        let dataSet = string.map { String($0) }
        let sorted = quicksort(dataSet)
        
        return sorted.joined()
    }
    
    
    func quicksort<T: Comparable>(_ a: [T]) -> [T] {
      guard a.count > 1 else { return a }

      let pivot = a[a.count/2]
      let less = a.filter { $0 < pivot }
      let equal = a.filter { $0 == pivot }
      let greater = a.filter { $0 > pivot }

      return quicksort(less) + equal + quicksort(greater)
    }
}
