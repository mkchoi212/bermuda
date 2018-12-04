//
//  UIView+Shadow.swift
//  bermuda
//
//  Created by Mike Choi on 12/2/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.15
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
