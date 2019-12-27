//
//  LoadingButton.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-26.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import UIKit

private var buttonText = ""

extension UIButton {
    
    func loadingIndicator(_ show: Bool, _ tag: Int) {
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView(frame: self.frame)
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            buttonText = titleLabel?.text ?? ""
            //setTitle("", for: .normal)
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            setTitle(buttonText, for: .normal)
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
