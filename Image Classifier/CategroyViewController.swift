//
//  CategroyViewController.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/8/10.
//  Copyright © 2020 LafuenteR. All rights reserved.
//

import UIKit

class CategroyViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func recyclable(_ sender: Any) {
        let recyclableVC = storyboard!.instantiateViewController(withIdentifier: "RecyclableVC") as! RecyclableViewController
        
        recyclableVC.transitioningDelegate = self
        recyclableVC.modalPresentationStyle = .fullScreen
        present(recyclableVC, animated: true, completion: nil)

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
