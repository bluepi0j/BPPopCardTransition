//
//  BPPopCardPresentingAnimationController.swift
//  BPPopCardTransition
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import Foundation


final class BPPopCardPresentingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        let presentingViewController: UIViewController = transitionContext.viewController(forKey: .from)!
        let presentedViewController: UIViewController = transitionContext.viewController(forKey: .to)!

        let containerView = transitionContext.containerView
        
        var cellFrame: CGRect = .zero
        
        cellFrame = (delegate?.rectZoomPosition())!
        presentedViewController.view.frame = transitionContext.finalFrame(for: presentedViewController)
        
//        presentedViewController.view.clipsToBounds = true
        presentedViewController.view.layer.cornerRadius = 8
        
        // snapshot of presentedViewController
        let resizableSnapshotView: UIView = presentedViewController.view.resizableSnapshotView(from: presentedViewController.view.bounds, afterScreenUpdates: true, withCapInsets: .zero)!
        resizableSnapshotView.frame = cellFrame
        containerView.addSubview(resizableSnapshotView)
        
        
        let imageView: UIImageView = (self.delegate?.cellImageView())!
        
        let resizableSnapshotImageView: UIView = imageView.resizableSnapshotView(from: imageView.bounds, afterScreenUpdates: true, withCapInsets: .zero)!
        resizableSnapshotImageView.frame = cellFrame
 
        resizableSnapshotImageView.layer.masksToBounds = true
        resizableSnapshotImageView.layer.cornerRadius = 8;

        containerView.addSubview(resizableSnapshotImageView)
        
        
        UIView.animate(withDuration: 0.3) { 
            if self.shouldFadeBackgroundViewController! {
                presentingViewController.view.alpha = 0.7
            }
        }
        
        
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: animationSpringDampening!,
                       initialSpringVelocity: animationSpringVelocity!,
                       options: .curveEaseInOut,
                       animations: {
                        resizableSnapshotImageView.frame = CGRect(x: transitionContext.finalFrame(for: presentedViewController).origin.x, y:transitionContext.finalFrame(for: presentedViewController).origin.y, width: transitionContext.finalFrame(for: presentedViewController).size.width, height: resizableSnapshotImageView.frame.size.height)
                        
                        
        }) { (finished) in
            resizableSnapshotImageView.removeFromSuperview()
        }
        
        
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: animationSpringDampening!,
                       initialSpringVelocity: animationSpringVelocity!,
                       options: .curveEaseInOut,
                       animations: {
                        resizableSnapshotImageView.frame = CGRect(x: transitionContext.finalFrame(for: presentedViewController).origin.x, y:transitionContext.finalFrame(for: presentedViewController).origin.y, width: transitionContext.finalFrame(for: presentedViewController).size.width, height: resizableSnapshotImageView.frame.size.height)
                        
                        resizableSnapshotView.frame = transitionContext.finalFrame(for: presentedViewController)
            
                        }) { (finished) in
                            containerView.addSubview(presentedViewController.view)
                            resizableSnapshotView.removeFromSuperview()
                            resizableSnapshotImageView.removeFromSuperview()
                            transitionContext.completeTransition(finished)
                        }
        
    
    
    }


    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration!
    }
}
