//
//  FibonacciNumber.swift
//  TutsplusFibonacci
//
//  Created by Markus Mühlberger on 02/10/2016.
//  Copyright © 2016 Markus Mühlberger. All rights reserved.
//

import Foundation

class FibonacciNumber {
    private let previousIndexA : FibonacciNumber?
    private let previousIndexB : FibonacciNumber?
    
    var previousNumber : FibonacciNumber? {
        get {
            return previousIndexB
        }
    }
    
    var value : Int {
        get {
            var A, B : Int
            
            if let previousIndexA = previousIndexA {
                A = previousIndexA.value
            } else {
                A = 0
            }
            
            if let previousIndexB = previousIndexB {
                B = previousIndexB.value
            } else {
                B = 1
            }
            
            return A + B
        }
    }
    
    init(previousNumber: FibonacciNumber?) {
        previousIndexB = previousNumber
        previousIndexA = previousNumber?.previousNumber
    }
}

extension FibonacciNumber {
    func nextNumber() -> FibonacciNumber {
        return FibonacciNumber(previousNumber: self)
    }
    
    func previousNumbers() -> [Int] {
        var previousNumber = self.previousNumber
        var returnArray = [Int]()
        
        while let previous = previousNumber, previous.value > 0 {
            returnArray.append(previous.value)
            previousNumber = previous.previousNumber
        }
        
        return returnArray
    }
}

fileprivate extension FibonacciNumber {
    func previousValue() -> Int {
        if let previousNumber = previousNumber {
            return previousNumber.value
        } else {
            return 0
        }
    }
}










