//
//  UIView+Extension.swift
//  TopGames
//
//  Created by Hellen on 02/11/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addBlurToView() {
        var blurEffect: UIBlurEffect!
        
        blurEffect = UIBlurEffect(style: .light)
        
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = 1
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurredEffectView)
    }
}
