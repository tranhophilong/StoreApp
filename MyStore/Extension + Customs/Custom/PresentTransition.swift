//
//  PresentTransition.swift
//  MyStore
//
//  Created by Long Tran on 26/06/2023.
//

import UIKit

class PresentTransition : NSObject, UIViewControllerAnimatedTransitioning {
    var animator : UIViewImplicitlyAnimating?
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
        
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.animator != nil {
            return self.animator!
        }
        
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        
    
        let fromViewInitalFrame = transitionContext.initialFrame(for: fromVC)
//        var fromViewFinalFrame =  fromViewInitalFrame
//
//        fromViewFinalFrame.origin.x = -fromViewFinalFrame.width
        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!
        var toViewInitialFrame = fromViewInitalFrame
        toViewInitialFrame.origin.x = toView.frame.size.width
        toView.frame = toViewInitialFrame
        container.addSubview(toView)
        
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut){
            toView.frame = fromViewInitalFrame
            fromView.frame = fromViewInitalFrame
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }
        
        self.animator = animator
        return animator
        
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator = nil
    }
    
    
}
