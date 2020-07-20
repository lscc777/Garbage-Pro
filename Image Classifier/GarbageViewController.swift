//
//  GarbageViewController.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/7/20.
//  Copyright © 2020 LafuenteR. All rights reserved.
//

import UIKit
import Foundation

class GarbageViewController: UIViewController {

    var image: UIImage?
    var name: String?
    
    let textMlmodel = TextClassifier()
    let categroy = ["1": "可回收垃圾", "2": "有害垃圾", "4": "湿垃圾", "8": "干垃圾", "16": "大型垃圾"]

    @IBOutlet weak var garbageImage: UIImageView!
    @IBOutlet weak var garbageName: UILabel!
    @IBOutlet weak var garbageCategroy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        garbageImage.image = image
        garbageName.text = "垃圾名称: \(name!)"
        
        guard let predictionResult = try? textMlmodel.prediction(text: name!) else {
            fatalError("Predicting errors!")
        }

        if let result = categroy[predictionResult.label] {
            print(result)
            garbageCategroy.text = "垃圾种类: \(result)"
        }
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
