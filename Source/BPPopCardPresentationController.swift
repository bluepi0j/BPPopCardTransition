//
//  BPPopCardPresentationController.swift
//  BPPopCardTransition
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import Foundation

class BPPopCardPresentationController: UIPresentationController, UIGestureRecognizerDelegate {
    
    var pan: UIPanGestureRecognizer?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        if let view = containerView {
            let widthOffset: CGFloat = 20
            let heightOffset: CGFloat = 40
            return CGRect(x: widthOffset, y: heightOffset, width: view.bounds.size.width - widthOffset * 2, height: view.bounds.size.height - heightOffset * 2)
        } else {
            return .zero
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if completed {
            pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            pan?.delegate = self
            pan?.maximumNumberOfTouches = 1
            presentedViewController.view.addGestureRecognizer(pan!)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            presentingViewController.view.alpha = 1.0
            presentingViewController.view.layer.cornerRadius = 0
        }
    }
    
    func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.isEqual(pan) else {
            return
        }
        
        switch gestureRecognizer.state {
            
        case .began:
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: containerView)
            
        case .changed:
            if let view = presentedView {
                /// The dismiss gesture needs to be enabled for the pan gesture
                /// to do anything.
                self.updatePresentedViewForTranslation(translationX: gestureRecognizer.translation(in: view).x, translationY: gestureRecognizer.translation(in: view).y)
            }
            
        case .ended:
            UIView.animate(
                withDuration: 0.25,
                animations: {
                    self.presentedView?.transform = .identity
                }
            )
            
        default: break
            
        }
    }
    
    func updatePresentedViewForTranslation(translationX: CGFloat, translationY: CGFloat) {
        
        presentedView?.transform = CGAffineTransform(translationX: translationX, y: translationY)
        UIView.animate(withDuration: 0.35, animations: {
            self.presentedView?.frame = CGRect(x: (self.presentedView?.frame.origin.x)! + translationX * 2.2, y: (self.presentedView?.frame.origin.y)!  + translationY * 2.2, width: (self.presentedView?.frame.size.width)!, height: (self.presentedView?.frame.size.height)!)
            }, completion: { (finished) in
                let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                self.presentedViewController.dismiss(animated: false, completion: {
                })
            })
       
        }
        
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
}
