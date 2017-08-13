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
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration!
    }
}
