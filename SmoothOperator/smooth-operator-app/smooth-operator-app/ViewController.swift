//
//  ViewController.swift
//  smooth-operator-app
//
//  Created by Justin Trantham on 10/7/21.
//

import UIKit
import smooth_operator_lib

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // Example implementation
    let smoothOperatorLibExample = SmoothOperatorCLI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let result = try smoothOperatorLibExample.evaluateExpression(expression: "1/2 * 3_3/4")
            print("Result of 1/2 * 3_3/4 --> \(result)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    @IBAction func evaluateButton(_ sender: Any) {
        do {
            let result = try smoothOperatorLibExample.evaluateExpression(expression: "\(textField.text ?? "")")
            print("Result of 1/2 * 3_3/4 --> \(result)")
            
            DispatchQueue.main.async { [weak self] in
                let split = result.split(separator: "/")
                if split.count == 2 {
                    self?.label.text = """
                    \(split.first!)
                    ---
                    \(split.last!)
                    """
                } else {
                    self?.label.text = "\(result)"
                }
            }
            
        } catch {
            print("Error: \(error)")
            
            DispatchQueue.main.async { [weak self] in
                self?.label.text = "\(error)"
            }
        }
    }
}

