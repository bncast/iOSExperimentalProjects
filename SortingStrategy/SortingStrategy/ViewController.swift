//
//  ViewController.swift
//  SortingStrategy
//
//  Created by Nino on 3/27/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var strategySegment: UISegmentedControl!
    @IBOutlet weak var sortButton: UIButton!
    
    var sortStrategy:SortStrategy = BubbleSortStrategy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Sorting"
        
        inputTextField.placeholder = "Enter input string"
        
        strategySegment.setTitle("Bubble Sort", forSegmentAt: 0)
        strategySegment.setTitle("Quick Sort", forSegmentAt: 1)
        
        sortButton.setTitle("Sort", for: .normal)
        
        outputLabel.text = ""
    }

    @IBAction func sortButtonTapped(_ sender: Any) {
        if let input = inputTextField.text, input.isEmpty == false {
            outputLabel.text = sortStrategy.sort(input)
        } else {
            let alert = UIAlertController(title: "Invalid input", message: "Input string cannot be empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.inputTextField.becomeFirstResponder()
            }
            
            alert.addAction(action)
            
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func strategySegmentValueChanged(_ sender: Any) {
        outputLabel.text = ""
        switch strategySegment.selectedSegmentIndex {
        case 0:
            sortStrategy = BubbleSortStrategy()
            break
        case 1:
            sortStrategy = QuickSortStrategy()
            break
        default:
            break
        }
    }
}

