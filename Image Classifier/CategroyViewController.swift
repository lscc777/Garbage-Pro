//
//  CategroyViewController.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/8/10.
//  Copyright © 2020 LafuenteR. All rights reserved.
//

import UIKit

class CategroyViewController: UIViewController {
    
    @IBOutlet weak var back: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        back.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "1":
            let vc = segue.destination as! RecyclableViewController
            vc.num = 1
        case "2":
            let vc = segue.destination as! RecyclableViewController
            vc.num = 2
        case "3":
            let vc = segue.destination as! RecyclableViewController
            vc.num = 3
        case "4":
            let vc = segue.destination as! RecyclableViewController
            vc.num = 4
        default:
            return
        }
        
    }
    
    
}
