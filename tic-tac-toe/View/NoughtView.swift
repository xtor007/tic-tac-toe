//
//  NoughtView.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import UIKit

class NoughtView: UIView, CrossNoughtView {
    
    var bigCircle: UIView!

    override func draw(_ rect: CGRect) {
        
        bigCircle = UIView(frame: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        bigCircle.layer.cornerRadius = rect.width/2
        bigCircle.backgroundColor = .red
        addSubview(bigCircle)
        
        let littleCircle = UIView(frame: CGRect(x: rect.width/10, y: rect.height/10, width: 4*rect.width/5, height: 4*rect.height/5))
        littleCircle.layer.cornerRadius = 2*rect.width/5
        littleCircle.backgroundColor = .white
        addSubview(littleCircle)
        
        bigCircle.alpha = 0
        
    }
    
    func animate() {
        bigCircle.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.bigCircle.alpha = 1
        }
    }

}
