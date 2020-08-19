//
//  RecyclableViewController.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/8/10.
//  Copyright © 2020 LafuenteR. All rights reserved.
//

import UIKit

class RecyclableViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var detail: UIImageView!
    
    var num = 1
    var images = ["1","2","3","4"]
    var details = ["11","22","33","44"]
    var msg = [
        "可回收物是指经加工可以成为生产原料或者经过处理可以再利用的物品，主要包括废纸、塑料、金属、玻璃等。",
        "有害垃圾是指垃圾中对人体健康或自然环境造成直接或潜在危害的物质。包括废充电电池、灯管、废水银温度计、废油漆桶、过期药品等日常用品，这些垃圾需要特殊安全处理。",
        "厨余垃圾俗称“湿垃圾”，包括居民家庭产生的剩菜剩饭、菜根菜叶、瓜果皮核渣、动物内脏、过期食品等食品废物以及农贸市场的有机垃圾。",
        "其他垃圾俗称“干垃圾”。包括除上述几类垃圾之外的砖瓦陶瓷、尘土、卫生间废纸、纸巾等。",
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = UIImage(named: images[num-1])
        self.label.text = msg[num-1]
        self.detail.image = UIImage(named: details[num-1])
        
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
