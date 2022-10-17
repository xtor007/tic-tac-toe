//
//  FinishGameVC.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 17.10.2022.
//

import UIKit

enum GameStatus {
    
    case win, draw, lose
    
    func getText() -> String {
        switch self {
        case .win:
            return "WIN"
        case .draw:
            return "DRAW"
        case .lose:
            return "LOSE"
        }
    }
    
    func getColor() -> UIColor {
        switch self {
        case .win:
            return .green
        case .draw:
            return .yellow
        case .lose:
            return .red
        }
    }
    
}

class FinishGameVC: UIViewController {
    
    let status: GameStatus
    let duration: AlgoWorkDuration
    let delegate: FatherViewDelegate
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = status.getText()
        statusLabel.textColor = status.getColor()
        let (maxTime, minTime, averageTime) = duration.getStat()
        statLabel.text = "Max time = \(maxTime)\nMin time = \(minTime)\nAverage time = \(averageTime)"
    }
    
    init(status: GameStatus, duration: AlgoWorkDuration, delegate: FatherViewDelegate) {
        self.status = status
        self.duration = duration
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate.close()
        }
    }
    
}
