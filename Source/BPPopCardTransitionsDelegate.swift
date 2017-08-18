//
//  BPPopCardTransitionsDelegate.swift
//  BPPopCardTransition
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import Foundation

public final class BPPopCardTransitionsDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    public weak var deleagte: BPPopCardAnimtionDelegate?
    // MARK:- UIViewControllerTransitioningDelegate
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentedAnimator: BPPopCardPresentingAnimationController = BPPopCardPresentingAnimationController()
        presentedAnimator.delegate = deleagte
        return presentedAnimator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let dismissedAnimator: BPPopCardDismissingAnimationController = BPPopCardDismissingAnimationController()
        dismissedAnimator.delegate = deleagte
        return dismissedAnimator
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController: BPPopCardPresentationController = BPPopCardPresentationController(presentedViewController: presented, presenting: presenting)
        
        return presentationController
    }
}
