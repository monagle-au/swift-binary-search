//
//  RandomAccessCollection+binarySearch.swift
//
//
//  Created by David Monagle on 10/5/20.
//  from: https://stackoverflow.com/questions/40226479/stridable-protocol
//

import Foundation

public extension RandomAccessCollection {
    /// Performs a binary search on the collection
    /// - Parameter predicate: Defines a match
    /// - Returns: The first `Index` for which the predicate is not true
    ///
    /// If you want the index of the last matching element, use predicate `{ $0.date < targetDate }`
    func binarySearchIndex(predicate: (Iterator.Element) -> Bool) -> Index {
        var low = startIndex
        var high = endIndex
        while low != high {
            let mid = index(low, offsetBy: distance(from: low, to: high)/2)
            if predicate(self[mid]) {
                low = index(after: mid)
            } else {
                high = mid
            }
        }
        return low
    }

    func binarySearchIndex<Value>(_ keyPath: KeyPath<Element, Value>, nearest value: Value) -> Index where Value : Comparable {
        binarySearchIndex(predicate: { $0[keyPath: keyPath] < value })
    }
    
    /// Returns the first element where the keypath  matches the given value
    func binarySearch<Value>(_ keyPath: KeyPath<Element, Value>, matching value: Value) -> Element? where Value : Comparable & Equatable {
        guard let nearest = binarySearch(keyPath, nearest: value), nearest[keyPath: keyPath] == value else { return nil }
        return nearest
    }
    
    /// Returns the first element where the keyPath is equal to or greater than the `nearest` value
    func binarySearch<Value>(_ keyPath: KeyPath<Element, Value>, nearest value: Value) -> Element? where Value : Comparable {
        let index = binarySearchIndex(keyPath, nearest: value)
        guard index != self.endIndex else { return nil }
        return self[index]
    }
    
    func binarySlice<Value>(from: Value? = nil, until: Value? = nil, inclusive: Bool = false, on: (Element) -> Value) -> ArraySlice<Element> where Value: Comparable {
        let startSlice: Index
        let endSlice: Index
        
        if let from = from {
            startSlice = binarySearchIndex(predicate: { on($0) < from })
            guard startSlice < endIndex else { return [] }
        }
        else {
            startSlice = self.startIndex
        }
        
        if let until = until {
            var index = binarySearchIndex(predicate: { on($0) < until })
            if inclusive && index < self.endIndex {
                index = self.index(after: index)
            }
            endSlice = index
        }
        else {
            endSlice = self.endIndex
        }
        
        let slice = ArraySlice(self[startSlice ..< endSlice])
        return slice
    }
    
    func binarySlice(from: Element? = nil, until: Element? = nil, inclusive: Bool = false) -> ArraySlice<Element> where Element: Comparable {
        self.binarySlice(from: from, until: until, inclusive: inclusive, on: { $0 })
    }
    
}

public extension Array {
    // Insert a value into the collection sorted by the given keyPath
    mutating func binarySortedInsert<Value>(_ element: Element, on keyPath: KeyPath<Element, Value>) where Value : Comparable & Equatable, Index == Int {
        let value = element[keyPath: keyPath]
        let index = binarySearchIndex(keyPath, nearest: value)
        self.insert(element, at: index)
    }
}
