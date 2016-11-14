//
//  ViewController.swift
//  Facelt
//
//  Created by Pavel Hrybouski on 10.11.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    
    
    

    var expression = FacialExpression(mouth: .Smile, eyes: .Open, eyeBrows: .Normal){
        didSet{
            updateUI()
        }
    }
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            let happierSwipeGesturerecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGesturerecognizer.direction = .down
            faceView.addGestureRecognizer(happierSwipeGesturerecognizer)
            
            let sadderSwipeGesturerecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseSadness))
            sadderSwipeGesturerecognizer.direction = .up
            faceView.addGestureRecognizer(sadderSwipeGesturerecognizer)
            
            updateUI()
        }
    }
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
 //           default:
//                break

            }
        }
        
    }
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    func increaseSadness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    private var mouthCurvates = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Smirk: -0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Furrowed: -0.5, .Normal: 0.0, .Relaxed: 0.5]
    
    private func updateUI() {
        switch expression.eyes {
        case .Open:
            faceView?.eyesOpen = true
        case .Closed:
            faceView?.eyesOpen = false
        case .Squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvates[expression.mouth] ?? 0.0
        faceView?.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        
        
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        /*
         We override viewWillTransition(to size: with coordinator:) in order to add special behavior
         when the app changes size, especially when the device is rotated.
         In this demo app, we add an effect to make the items "pop" towards the viewer during the rotation,
         and then go back to normal afterwards.
         */
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // If self.stackView is nil, then our view has not yet been loaded, and there is nothing to do.
        
        
        guard let stackView = faceView else { return }
        
        // Add alongside and completion animations.
        coordinator.animate(alongsideTransition:
            { _ in
                /*
                 Scale the stackView to be larger than normal.
                 This animates along with the rest of the rotation animation.
                 */
                stackView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        },
                            completion:
            { _ in
                /*
                 The rotation animation is complete. Add an additional 0.5 second
                 animation to set the scale back to normal.
                 */
                UIView.animate(withDuration: 0.5, animations: {
                    stackView.transform = CGAffineTransform.identity
                })
        }
        )
    }
    override func viewWillDisappear(_ animated: Bool) {
             let stackView = faceView!
            


                    stackView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6
        )

                    UIView.animate(withDuration: 0.5, animations: {
                        stackView.transform = CGAffineTransform.identity
                    })
            }
    override func viewWillAppear(_ animated: Bool) {
        
        let stackView = faceView!

        stackView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)

        UIView.animate(withDuration: 0.5, animations: {
            stackView.transform = CGAffineTransform.identity
        })
    }




}

