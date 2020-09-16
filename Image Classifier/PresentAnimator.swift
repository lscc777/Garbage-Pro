//
//  PresentAnimator.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/9/16.
//  Copyright © 2020 LafuenteR. All rights reserved.
//

import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else{return}
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        
        toView.alpha = 0
        toView.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromView.alpha = 0
                fromView.transform = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
                toView.alpha = 1
                toView.transform = .identity
        }) { _ in
            fromView.transform = .identity
            toView.transform = .identity
            
            transitionContext.completeTransition(true)
        }
        
    }
    
    
}
