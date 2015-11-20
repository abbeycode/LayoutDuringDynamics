//
//  CustomView.swift
//  LayoutDuringDynamics
//
//  Created by Dov Frankel on 11/20/15.
//  Copyright © 2015 Dov Frankel. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var swingingView: UIView!
    
    var animator: UIDynamicAnimator!
    var attachment: UIAttachmentBehavior!
    
    var lastViewFrame = CGRectZero


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        swingingView = UIImageView(image: UIImage(named: "Star"))
        self.addSubview(swingingView)
    }
    
    override func layoutSubviews() {
        guard self.frame != lastViewFrame else {
            return
        }
        
        lastViewFrame = self.frame
        
        swingingView.frame = CGRect(x: 0, y: self.frame.size.height / 2, width: 100, height: 100)
        
        if animator == nil {
            animator = UIDynamicAnimator(referenceView: self)
            
            let gravity = UIGravityBehavior(items: [swingingView])
            gravity.magnitude = 1.5
            animator.addBehavior(gravity)
            
            attachment = swingAttachment(swingingView)
            animator.addBehavior(attachment)
        }
        
        animator.updateItemUsingCurrentState(swingingView)
    }
    
    let Springlength = CGFloat(250.0)
    
    private func swingAttachment(view: UIView) -> UIAttachmentBehavior {
        let attachment = UIAttachmentBehavior(item: view, offsetFromCenter: UIOffset(horizontal: 0, vertical: view.frame.size.height / -2),
            attachedToAnchor: CGPoint(x: self.bounds.size.width / 2, y: 0))
        attachment.length = Springlength
        
        return attachment
    }
}