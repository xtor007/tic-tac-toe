//
//  GameVC.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import UIKit

class GameVC: UIViewController {
    
    let model: GameViewModel
    
    var buttons = [Coordinates:UIButton]()
    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellSize = boardView.frame.width/10
        for x in 0..<10 {
            for y in 0..<10 {
                let button = UIButton(frame: CGRect(
                    x: CGFloat(x)*cellSize,
                    y: CGFloat(y)*cellSize,
                    width: cellSize, height: cellSize
                ))
                button.tag = y*10 + x
                button.layer.borderWidth = 3
                button.layer.borderColor = UIColor.darkGray.cgColor
                button.addTarget(self, action: #selector(move(sender:)), for: .touchUpInside)
                boardView.addSubview(button)
                buttons[Coordinates(x: x, y: y)] = button
            }
        }
    }

    init(model: GameViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func move(sender: UIButton) {
        let coordinates = Coordinates(tag: sender.tag)
        if model.isMovePossible(coordinates: coordinates) {
            if let frame = buttons[coordinates]?.frame {
                let crossView = CrossView(frame: frame)
                boardView.addSubview(crossView)
                if let winner = model.position.winner() {
                    print(winner)
                    return
                }
                model.getMove { noughtCoordinates in
                    if let frame = self.buttons[noughtCoordinates]?.frame {
                        let noughtView = NoughtView(frame: frame)
                        self.boardView.addSubview(noughtView)
                        if let winner = self.model.position.winner() {
                            print(winner)
                        }
                        if self.model.position.countOfEmpty == 0 {
                            print("draw")
                        }
                    }
                }
            }
        }
    }
    
}
