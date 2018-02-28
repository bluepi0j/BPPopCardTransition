//
//  BPPopCardAnimtionDelegate.swift
//  BPPopCardTransition
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol BPPopCardAnimtionDelegate: class {
    /**
     *  The rect that the ToView will go to. This should be relative to the view controller.
     *
     *  @return The rect to insert the ToView into.
     */
    func rectZoomPosition() -> CGRect
    func cellImageView() -> UIImageView
    func popCardViewBannerHeight() -> CGFloat
 
}

extension UIView {
    public func roundCorners(_ corners: UIRectCorner, withRadius radius:CGFloat) {
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
