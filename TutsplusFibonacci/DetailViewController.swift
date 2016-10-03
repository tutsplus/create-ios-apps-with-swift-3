//
//  DetailViewController.swift
//  TutsplusFibonacci
//
//  Created by Markus Mühlberger on 02/10/2016.
//  Copyright © 2016 Markus Mühlberger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.font = UIFont.boldSystemFont(ofSize: 18)
                label.text = String(detail.value)
                
                var previousView : UILabel = label
                
                for number in detail.previousNumbers() {
                    let numberLabel = UILabel()
                    numberLabel.translatesAutoresizingMaskIntoConstraints = false
                    numberLabel.text = String(number)
                    
                    view.addSubview(numberLabel)
                    
                    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[previousView]-[currentView]", options: [], metrics: [:], views: [
                        "previousView" : previousView,
                        "currentView" : numberLabel
                    ]))
                    view.addConstraint(NSLayoutConstraint(item: numberLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
                    
                    numberLabel.sizeToFit()
                    
                    previousView = numberLabel
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: FibonacciNumber? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

