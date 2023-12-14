//
//  DismissTransition.swift
//  MyStore
//
//  Created by Long Tran on 26/06/2023.
//

import UIKit

class DismissTransition : NSObject, UIViewControllerAnimatedTransitioning{
    var animator  : UIViewImplicitlyAnimating?
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.animator != nil {
            return self.animator!
        }
        let fromVc  = transitionContext.viewController(forKey: .from)!
        var fromViewIntialFrame = transitionContext.initialFrame(for: fromVc)
        
//        fromViewIntialFrame.origin.x = 0
        var fromViewFinalFrame = fromViewIntialFrame
        fromViewFinalFrame.origin.x = fromViewFinalFrame.width

        let fromView = fromVc.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!
        
        var toViewIntialFrame = fromViewIntialFrame
        toViewIntialFrame.origin.x = 0
        toView.frame = toViewIntialFrame
        
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut){
            toView.frame = fromViewIntialFrame
            fromView.frame = fromViewFinalFrame
            
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
