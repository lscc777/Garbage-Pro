//
//  SearchViewController.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/8/16.
//  Copyright © 2020 LafuenteR. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: UIViewController,UISearchBarDelegate {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    
    let textMlmodel = TextClassifier()
    let categroy = ["1": "可回收垃圾", "2": "有害垃圾", "4": "湿垃圾", "8": "干垃圾", "16": "大型垃圾"]
    var text: String = ""
    
    @IBAction func search(_ sender: Any) {
        
        if let textfieled = textField.text {
            self.text = textfieled
        }
        
        guard let predictionResult = try? textMlmodel.prediction(text: self.text) else {
            fatalError("Predicting errors!")
        }

        if let result = categroy[predictionResult.label] {
            print(result)
            name.text = "垃圾名称: \(text)"
            category.text = "垃圾种类: \(result)"
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
