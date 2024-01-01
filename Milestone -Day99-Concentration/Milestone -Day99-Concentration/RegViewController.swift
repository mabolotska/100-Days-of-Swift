//
//  RegViewController.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 31/12/23.
//

import UIKit
import LocalAuthentication

class RegViewController: UIViewController {
    
    let mainView: UIView = {
          let view = UIView()
          return view
      }()
    
    let userTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.font = UIFont(name: "FunSized", size: 36)
        return textField
    }()
    
    let passTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont(name: "FunSized", size: 36)
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont(name: "FunSized", size: 36)
        button.addTarget(self, action: #selector(registration), for: .touchUpInside)
        return button
    }()
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.titleLabel?.font = UIFont(name: "FunSized", size: 36)
        button.addTarget(self, action: #selector(comeBack), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        inizialize()
    }
    
    
    
    func save(login: String, password: String) {
      
        KeychainWrapper.standard.set(login, forKey: "userLoginKey")
        KeychainWrapper.standard.set(password, forKey: "userPasswordKey")
       
    }

    @objc func registration() {
        guard let login = userTF.text else { return }
        guard let password = passTF.text else { return }
        save(login: login, password: password)
        print(login)
        
        let ac = UIAlertController(title: "All saved", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            let secondVC = LoginViewController()
            
            
            self?.navigationController?.pushViewController(secondVC, animated: true)
            
         
        }
        ac.addAction(submitAction)
       
       
        present(ac, animated: true)
        
    }

    @objc func comeBack() {
        let secondVC = LoginViewController()
        
        
        navigationController?.pushViewController(secondVC, animated: true)
    }

}

private extension RegViewController {

    
    
    
    func inizialize() {
        view.addSubview(mainView
        
        )
        view.backgroundColor = .white
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(userTF)
        stack.addArrangedSubview(passTF)
        stack.addArrangedSubview(enterButton)
        stack.addArrangedSubview(exitButton)
        stack.alignment = .center
        stack.spacing = 30
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
 
        
        if let placeholder = userTF.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                   userTF.attributedPlaceholder = attributedPlaceholder
               }
        
        if let placeholder = passTF.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            passTF.attributedPlaceholder = attributedPlaceholder
               }
        
        
 let backgroundImage = UIImageView(image: UIImage(named: "lokoBack2"))
        backgroundImage.contentMode = .scaleAspectFill
        mainView.addSubview(backgroundImage)

        // SnapKit constraints for the background image
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(stack)
 
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
          //  make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(250)
        }
    }
}
