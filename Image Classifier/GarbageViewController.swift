//
//  GarbageViewController.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/7/20.
//  Copyright © 2020 LafuenteR. All rights reserved.
//

import UIKit

class GarbageViewController: UIViewController {

    var image: UIImage?
    var name: String?
    
    @IBOutlet weak var garbageImage: UIImageView!
    @IBOutlet weak var garbageName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        garbageImage.image = image
        garbageName.text = name
        // Do any additional setup after loading the view.
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
