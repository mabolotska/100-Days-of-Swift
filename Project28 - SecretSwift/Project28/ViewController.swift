//
//  ViewController.swift
//  Project28
//
//  Created by TwoStraws on 19/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import LocalAuthentication
import UIKit

@available(iOS 16.0, *)
class ViewController: UIViewController {
	@IBOutlet var secret: UITextView!

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Nothing to see here"
        
        

		let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
	}

	@objc func adjustForKeyboard(notification: Notification) {
		let userInfo = notification.userInfo!

        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
			secret.contentInset = UIEdgeInsets.zero
		} else {
			secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
		}

		secret.scrollIndicatorInsets = secret.contentInset

		let selectedRange = secret.selectedRange
		secret.scrollRangeToVisible(selectedRange)
	}

	@IBAction func authenticateTapped(_ sender: AnyObject) {
        showLogAlert()
        
        
//		let context = LAContext()
//		var error: NSError?
//
//		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//			let reason = "Identify yourself!"
//
//			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
//				[unowned self] (success, authenticationError) in
//
//				DispatchQueue.main.async {
//					if success {
//						self.unlockSecretMessage()
//                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.saveSecretMessage))
//					} else {
//						let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
//						ac.addAction(UIAlertAction(title: "OK", style: .default))
//						self.present(ac, animated: true)
//					}
//				}
//			}
//		} else {
//			let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
//			ac.addAction(UIAlertAction(title: "OK", style: .default))
//			self.present(ac, animated: true)
//		}
	}
    
    func showLogAlert() {
        let ac = UIAlertController(title: "Enter login and password", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
                   textField.placeholder = "Username"
               }

               ac.addTextField { textField in
                   textField.placeholder = "Password"
                   textField.isSecureTextEntry = true
               }
        
        let submitAction = UIAlertAction(title: "Log In", style: .default) { [weak self, weak ac] _ in
            guard let login = ac?.textFields?[0].text else { return }
            guard let password = ac?.textFields?[1].text else { return }
      
            if let savedLogin = self?.retrieveLogin(), let savedPassword = self?.retrievePassword() {
               
                      if login == savedLogin && password == savedPassword {
                         
                                  let context = LAContext()
                                  var error: NSError?
                          
                                  if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                                      let reason = "Identify yourself!"
                          
                                      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                                          [unowned self] (success, authenticationError) in
                          
                                          DispatchQueue.main.async {
                                              if success {
                                                  self?.unlockSecretMessage()
                                                  self?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self?.saveSecretMessage))
                                              } else {
                                                  let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                                                  ac.addAction(UIAlertAction(title: "OK", style: .default))
                                                  self?.present(ac, animated: true)
                                              }
                                          }
                                      }
                                  } else {
                                      let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
                                      ac.addAction(UIAlertAction(title: "OK", style: .default))
                                      self?.present(ac, animated: true)
                                  }
                      } else {
                         
                          self?.showErrorMessage()
                      }
                  } else {
                    
                      self?.showErrorMessage()
                  }
        }
        
    
        
        
        let regAction = UIAlertAction(title: "Register", style: .default) { [weak self] _ in
            self?.showRegAlert()
            
        }
       
        ac.addAction(submitAction)
        ac.addAction(regAction)
       
        present(ac, animated: true)
    }
    
    func showRegAlert() {
       
        let ac = UIAlertController(title: "Register login and password", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
                   textField.placeholder = "Username"
               }

               ac.addTextField { textField in
                   textField.placeholder = "Password"
                   textField.isSecureTextEntry = true
               }
        
        let submitAction = UIAlertAction(title: "Register", style: .default) { [weak self, weak ac] _ in
            guard let login = ac?.textFields?[0].text else { return }
            guard let password = ac?.textFields?[1].text else { return }
            self?.save(login: login, password: password)
            self?.showLogAlert()
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(submitAction)
        ac.addAction(cancel)
       
        present(ac, animated: true)
        }
    
    func save(login: String, password: String) {
      
        KeychainWrapper.standard.set(login, forKey: "userLoginKey")
        KeychainWrapper.standard.set(password, forKey: "userPasswordKey")
       
    }

	func unlockSecretMessage() {
		secret.isHidden = false
		title = "Secret stuff!"

		if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
			secret.text = text
		}
	}

	@objc func saveSecretMessage() {
		if !secret.isHidden {
			KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
			secret.resignFirstResponder()
			secret.isHidden = true
			title = "Nothing to see here"
            navigationItem.rightBarButtonItem?.isHidden = true
		}
	}
    
    func showErrorMessage() {
        let errorAlert = UIAlertController(title: "Error", message: "Invalid login or password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    func retrieveLogin() -> String? {
        return KeychainWrapper.standard.string(forKey: "userLoginKey")
    }

    func retrievePassword() -> String? {
        return KeychainWrapper.standard.string(forKey: "userPasswordKey")
        
    }
}

