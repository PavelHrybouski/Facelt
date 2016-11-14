//
//  EmotionsViewController.swift
//  Facelt
//
//  Created by Pavel Hrybouski on 14.11.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        guard let stackView = stackView else { return }
        
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
    private let emotionalFaces :Dictionary <String, FacialExpression> = [
        "angry": FacialExpression(mouth: .Frown, eyes: .Closed, eyeBrows: .Furrowed),
        "happy": FacialExpression(mouth: .Smile, eyes: .Open, eyeBrows: .Normal),
        "worried": FacialExpression(mouth: .Smirk, eyes: .Open, eyeBrows: .Relaxed),
        "mischievous": FacialExpression(mouth: .Grin, eyes: .Open, eyeBrows: .Furrowed)

]
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navVC = destinationVC as? UINavigationController{
            destinationVC = navVC.visibleViewController ?? destinationVC
        }
        if let faceVC = destinationVC as? FaceViewController{
            if let identifier = segue.identifier {
                if let expression = emotionalFaces [identifier] {
                     faceVC.expression = expression
                    if let sendingButton = sender as? UIButton {
                        faceVC.navigationItem.title = sendingButton.currentTitle

                    }
                }
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let stackView = self.stackView!

        
        
        stackView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)

        UIView.animate(withDuration: 0.5, animations: {
            stackView.transform = CGAffineTransform.identity
        })
    }
    
    

}
