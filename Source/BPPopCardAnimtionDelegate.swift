//
//  BPPopCardAnimtionDelegate.swift
//  BPPopCardTransition
//
//  Created by Vic on 2017-08-12.
//  Copyright © 2017 bluepi0j. All rights reserved.
//

import Foundation

public protocol BPPopCardAnimtionDelegate: class {
    /**
     *  The rect that the ToView will go to. This should be relative to the view controller.
     *
     *  @return The rect to insert the ToView into.
     */
    func rectZoomPosition() -> CGRect
    func cellImageView() -> UIImageView
 
}
