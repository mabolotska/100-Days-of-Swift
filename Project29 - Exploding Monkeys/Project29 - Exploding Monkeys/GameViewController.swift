//
//  GameViewController.swift
//  Project29 - Exploding Monkeys
//
//  Created by Maryna Bolotska on 12/12/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var currentGame: GameScene!
    
    @IBOutlet weak var angleSlider: UISlider!
    
    @IBOutlet weak var angleLabel: UILabel!
   
    @IBOutlet weak var velocitySlider: UISlider!
    
    @IBOutlet weak var velocityLabel: UILabel!

    @IBOutlet weak var launchButton: UIButton!
    
    @IBOutlet weak var playerNumber: UILabel!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        angleChanged(angleSlider as Any)
        velocityChanged(velocitySlider as Any)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func angleChanged(_ sender: Any) {
        
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
           angleLabel.isHidden = true

           velocitySlider.isHidden = true
           velocityLabel.isHidden = true

           launchButton.isHidden = true

           currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
       }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }

        angleSlider.isHidden = false
        angleLabel.isHidden = false

        velocitySlider.isHidden = false
        velocityLabel.isHidden = false

        launchButton.isHidden = false
    }
    
   
    
}
