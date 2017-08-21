//
//  BPPopCardPresentingAnimationController.swift
//  BPPopCardTransition
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import Foundation

class myImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners([.topLeft, .topRight], withRadius: 10)
    }
}

final class BPPopCardPresentingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var delegate: BPPopCardAnimtionDelegate?
    
    var shouldFadeBackgroundViewController: Bool?
    
    var animationSpringDampening: CGFloat?
    
    var animationSpringVelocity: CGFloat?
    
    var duration: TimeInterval?
    
    var cardCornerRadius: CGFloat?
    
    override init() {
        super.init()
        shouldFadeBackgroundViewController = true
        animationSpringDampening = 0.77;
        animationSpringVelocity = 2.0;
        duration = 0.3;
        cardCornerRadius = 8.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentingViewController: UIViewController = transitionContext.viewController(forKey: .from)!
        let presentedViewController: UIViewController = transitionContext.viewController(forKey: .to)!

        let containerView = transitionContext.containerView
        
        var cellFrame: CGRect = .zero
        
        cellFrame = (delegate?.rectZoomPosition())!
        presentedViewController.view.frame = transitionContext.finalFrame(for: presentedViewController)
        
        presentedViewController.view.clipsToBounds = true
        presentedViewController.view.roundCorners(.allCorners, withRadius: cardCornerRadius!)
        
        // snapshot of presentedViewController
        let resizableSnapshotView: UIView = presentedViewController.view.resizableSnapshotView(from: presentedViewController.view.bounds, afterScreenUpdates: true, withCapInsets: .zero)!
        resizableSnapshotView.frame = cellFrame
        containerView.addSubview(resizableSnapshotView)
        
        
        let imageView: UIImageView = (self.delegate?.cellImageView())!
        let newImage: myImageView = myImageView(frame: imageView.frame)
        
        newImage.image = imageView.image
        newImage.contentMode = .scaleAspectFill
//        let resizableSnapshotImageView: UIView = imageView.resizableSnapshotView(from: imageView.bounds, afterScreenUpdates: true, withCapInsets: .zero)!
        newImage.frame = cellFrame
 
        newImage.layer.masksToBounds = true
//        newImage.roundCorners([.topLeft, .topRight], withRadius: 8)
//        newImage.roundCorners(.allCorners, withRadius: cardCornerRadius!)

        containerView.addSubview(newImage)
        
        
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
                        newImage.frame = CGRect(x: transitionContext.finalFrame(for: presentedViewController).origin.x, y:transitionContext.finalFrame(for: presentedViewController).origin.y, width: transitionContext.finalFrame(for: presentedViewController).size.width, height: 191.3)
                        
                        
        }) { (finished) in
            newImage.removeFromSuperview()
        }
        
        
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: animationSpringDampening!,
                       initialSpringVelocity: animationSpringVelocity!,
                       options: .curveEaseInOut,
                       animations: {
                        newImage.frame = CGRect(x: transitionContext.finalFrame(for: presentedViewController).origin.x, y:transitionContext.finalFrame(for: presentedViewController).origin.y, width: transitionContext.finalFrame(for: presentedViewController).size.width, height: 191.3)

                        resizableSnapshotView.frame = transitionContext.finalFrame(for: presentedViewController)
                        if #available(iOS 10.0, *) {
                            let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                            
                        } else {
                            // Fallback on earlier versions
                        }
                        }) { (finished) in
                            containerView.addSubview(presentedViewController.view)
                            resizableSnapshotView.removeFromSuperview()
                            newImage.removeFromSuperview()
                            transitionContext.completeTransition(finished)
                        }
    }


    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration!
    }
}
