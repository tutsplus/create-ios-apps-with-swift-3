//
//  FibonacciDataSource.swift
//  TutsplusFibonacci
//
//  Created by Markus Mühlberger on 02/10/2016.
//  Copyright © 2016 Markus Mühlberger. All rights reserved.
//

import UIKit

class FibonacciDataSource : NSObject, UITableViewDataSource {
    var objects = [FibonacciNumber]()
    
    func addNewNumber(tableView: UITableView) {
        if let lastObject = objects.last {
            objects.append(lastObject.nextNumber())
        } else {
            objects.append(FibonacciNumber(previousNumber: nil))
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = "Calculating..."
        
        let object = self.objects[indexPath.row]
        object.asyncValue { (value) in
            DispatchQueue.main.async {
                cell.textLabel!.text = String(value)
            }
        }
        
        return cell
    }
}
