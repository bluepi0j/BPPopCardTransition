//
//  BPPopCardDismissingAnimationController.swift
//  BPPopCardTransition
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import Foundation

final class BPPopCardDismissingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var delegate: BPPopCardAnimtionDelegate?
    
    var shouldFadeBackgroundViewController: Bool?
    
    var animationSpringDampening: CGFloat?
    
    var animationSpringVelocity: CGFloat?
    
    var duration: TimeInterval?
    
    override init() {
        super.init()
        shouldFadeBackgroundViewController = true
        animationSpringDampening = 0.77;
        animationSpringVelocity = 2.0;
        duration = 0.3;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentingViewController: UIViewController = transitionContext.viewController(forKey: .to)!
        let presentedViewController: UIViewController = transitionContext.viewController(forKey: .from)!
        
        let container = transitionContext.containerView
        
        
        var cellFrame: CGRect = .zero
        
        cellFrame = (delegate?.rectZoomPosition())!
        
        
        let imageView: UIImageView = (delegate?.cellImageView())!
        
        let resizableSnapshotImageView: UIView = imageView.resizableSnapshotView(from: imageView.bounds, afterScreenUpdates: true, withCapInsets: .zero)!
        
        resizableSnapshotImageView.layer.masksToBounds = true
        resizableSnapshotImageView.layer.cornerRadius = 8;
        resizableSnapshotImageView.frame = CGRect(x: transitionContext.finalFrame(for: presentedViewController).origin.x, y:transitionContext.finalFrame(for: presentedViewController).origin.y, width: transitionContext.finalFrame(for: presentedViewController).size.width, height: resizableSnapshotImageView.frame.size.height)

        container.insertSubview(resizableSnapshotImageView, aboveSubview: presentedViewController.view)
        
        let resizableSnapshotView: UIView = presentedViewController.view.resizableSnapshotView(from: presentedViewController.view.bounds, afterScreenUpdates: true, withCapInsets: .zero)!
        resizableSnapshotView.frame = presentedViewController.view.frame;
        resizableSnapshotView.layer.masksToBounds = true;
        resizableSnapshotView.layer.cornerRadius = 8;
        
        container.insertSubview(resizableSnapshotView, aboveSubview: presentedViewController.view)
        presentedViewController.view.removeFromSuperview()
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: animationSpringDampening!,
                       initialSpringVelocity: animationSpringVelocity!,
                       options: .curveEaseInOut,
                       animations: {
                        resizableSnapshotView.frame = cellFrame
                        resizableSnapshotImageView.frame = cellFrame;
                        presentingViewController.view.alpha = 1.0
                        
                        if #available(iOS 10.0, *) {
                            let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                            
                        } else {
                            // Fallback on earlier versions
                        }    
                        
        }) { (finished) in
            resizableSnapshotView.removeFromSuperview()
            resizableSnapshotImageView.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
        
        
    }
        
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration!
    }
}
