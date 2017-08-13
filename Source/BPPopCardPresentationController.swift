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
            
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
}
