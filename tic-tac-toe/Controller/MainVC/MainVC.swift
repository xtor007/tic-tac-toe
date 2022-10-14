//
//  MainVC.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import UIKit

class MainVC: UIViewController {
    
    
    @IBOutlet var crossNoughtViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for view in crossNoughtViews {
            if let crossNoughtView = view as? CrossNoughtView {
                crossNoughtView.animate()
            }
        }
    }
    
    @IBAction func startGame(_ sender: Any) {
        if let button = sender as? UIButton {
            let gameViewModel = GameViewModel(algo: Algo(rawValue: button.tag)!)
            let gameVC = GameVC(model: gameViewModel)
            gameVC.modalPresentationStyle = .fullScreen
            present(gameVC, animated: true)
        }
    }

}
