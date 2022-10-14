//
//  CrossView.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import UIKit

class CrossView: UIView, CrossNoughtView {
    
    var views = [UIView]()

    override func draw(_ rect: CGRect) {
        let frame = CGRect(x: 9*rect.width/20, y: 0, width: rect.width/10, height: rect.height)
        views.append(UIView(frame: frame))
        views.append(UIView(frame: frame))
        for view in views {
            view.backgroundColor = .green
            addSubview(view)
        }
        animate()
    }
    
    func animate() {
        for view in views {
            view.transform = .identity
        }
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.views[0].transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
            self.views[1].transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/4))
        }
    }
    
}
