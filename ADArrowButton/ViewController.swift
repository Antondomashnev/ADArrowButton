//
//  ViewController.swift
//  ADArrowButton
//
//  Created by Anton Domashnev on 11/30/14.
//  Copyright (c) 2014 Anton Domashnev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var arrowButton: ADArrowButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrowButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enableDisableButtonClicked(sender: AnyObject)
    {
        self.arrowButton.setEnabled(!self.arrowButton.enabled, animated: true)
    }

}

