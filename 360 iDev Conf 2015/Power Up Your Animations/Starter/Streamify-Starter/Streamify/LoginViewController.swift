//
//  LoginViewController.swift
//  Streamify
//
//  Created by Marin Todorov on 8/11/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var fldUsername: UITextField!
    @IBOutlet weak var fldPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgBackground: UIImageView!
    
    var didAnimateFields = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Code to get fields out of the screen: 
        if (!didAnimateFields) {
            fldUsername.center.x -= view.bounds.width
            fldPassword.center.x -= view.bounds.width
            btnLogin.alpha = 0
            colorize()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, animations: {
            self.fldUsername.center.x += self.view.bounds.width
            self.didAnimateFields = true
        })
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: nil, animations: {
            self.fldPassword.center.x += self.view.bounds.width
            self.btnLogin.alpha = 1
        }, completion: nil)
        
    }
    
    @IBAction func actionLogin(sender: AnyObject) {
        view.endEditing(true)
        
        let animationDelay = UIView.animateAndChainWithDuration(0.25, delay: 0.0, options: .CurveEaseOut, animations: {
            self.btnLogin.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            self.btnLogin.layer.cornerRadius = 0
        },
            completion: nil)
        // 2nd animation, taken from Marin's Library
        .animateWithDuration(0.25, delay: 0.0, options: .CurveEaseIn, animations: {
                self.btnLogin.transform = CGAffineTransformIdentity
                        self.btnLogin.layer.cornerRadius = 40
        }, completion: nil)
        // 3rd Animation
        .animateWithDuration(0.25, delay: 0.0, options: .Repeat, animations: {
                self.btnLogin.alpha = 0.5
            }, completion:nil)
        
        delay(seconds: 2, {
            animationDelay.cancelAnimationChain(completion: {
                print("Animation finished")
                UIView.animateAndChainWithDuration(0.33, delay: 0, options: nil, animations: {
                    self.btnLogin.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    }, completion: nil)
                    
                    .animateWithDuration(0.25, delay: 0, options: .CurveEaseIn, animations: {
                        self.fldUsername.center.x -= self.view.bounds.width
                        }, completion: nil)
                    
                    .animateWithDuration(0.25, delay: 0, options: .CurveEaseIn, animations: {
                        self.fldPassword.center.x -= self.view.bounds.width
                        }, completion: {_ in
                            //push next screen
                            self.actionShowOnboarding()
                    })

            })
        })
    }
    
    func colorize() {
        
        let img = UIImageView(image: UIImage(named: "streamify-login-bg-desat"))
        img.contentMode = .ScaleAspectFill
        img.frame = imgBackground.frame
        view.insertSubview(img, aboveSubview: imgBackground)
        
        UIView.animateWithDuration(3, delay: 0.0, options: nil, animations: {
            img.alpha = 0
            }, completion: {_ in
                img.removeFromSuperview()
                println("Animation Completed")
        })
    }
}

extension LoginViewController: UITextViewDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        if count(textField.text) < 5 {
            textField.center.x += 1
            UIView.animateWithDuration(3.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 100, options: nil, animations: {
                    textField.center.x -= 1
                },
                completion: nil)
        }
    }
}

// MARK: - Starter project code
extension LoginViewController: StarterProjectCode {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipIfSeen(self, "OnBoardingViewController")
        
        btnLogin.layer.borderColor = UIColor(red: 20/255.0, green: 123/255.0, blue: 195/255.0, alpha: 1.0).CGColor
        btnLogin.layer.cornerRadius = 40
    }
    
    func actionShowOnboarding() {
        self.performSegueWithIdentifier("showOnBoarding", sender: self.btnLogin)
        markAsSeen(self, true)
    }
}
