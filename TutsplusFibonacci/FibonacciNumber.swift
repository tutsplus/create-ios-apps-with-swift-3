//
//  FibonacciNumber.swift
//  TutsplusFibonacci
//
//  Created by Markus Mühlberger on 02/10/2016.
//  Copyright © 2016 Markus Mühlberger. All rights reserved.
//

import Foundation

class FibonacciNumber {
    fileprivate let previousIndexA : FibonacciNumber?
    fileprivate let previousIndexB : FibonacciNumber?
    
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
    
    func asyncValue(completion: @escaping (Int) -> ()) {
        DispatchQueue.global().async {
            var A = 0, B = 1
            
            let queue = DispatchQueue(label: "Calculator", qos: .background, attributes: .concurrent)
            let group = DispatchGroup()
            
            if let previousIndexA = self.previousIndexA {
                group.enter()
                queue.async {
                    A = previousIndexA.value
                    group.leave()
                }
            }
            
            if let previousIndexB = self.previousIndexB {
                group.enter()
                queue.async {
                    B = previousIndexB.value
                    group.leave()
                }
            }
            
            group.wait()
            
            completion(A + B)
        }
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










