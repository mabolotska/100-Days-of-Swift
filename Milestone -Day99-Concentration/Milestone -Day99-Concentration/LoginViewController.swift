//
//  LoginViewController.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 31/12/23.
//

import UIKit

class LoginViewController: UIViewController {
    let secondVC = RegViewController()
   
    let mainView: UIView = {
          let view = UIView()
          return view
      }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.titleLabel?.font = UIFont(name: "FunSized", size: 36)
        button.addTarget(self, action: #selector(goToGame), for: .touchUpInside)
        return button
    }()
    
    let regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont(name: "FunSized", size: 36)
        button.addTarget(self, action: #selector(goToRegScreen), for: .touchUpInside)
        return button
    }()
    
    let idButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "face"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        inizialize()
        
       
    }
    
    
    @objc func goToRegScreen() {
       
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    
    @objc func goToGame() {
        showLogAlert()
    }
    
    
    func retrieveLogin() -> String? {
        return KeychainWrapper.standard.string(forKey: "userLoginKey")
    }

    func retrievePassword() -> String? {
        return KeychainWrapper.standard.string(forKey: "userPasswordKey")
        
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
                    self?.navigationController?.pushViewController(ViewController(), animated: true)
                }
            }
            
            
        }
        ac.addAction(submitAction)
        
       
        present(ac, animated: true)
    }

}


private extension LoginViewController {
    func inizialize() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        
               mainView.snp.makeConstraints { make in
                   make.edges.equalToSuperview()
               }
        
        let backgroundImage = UIImageView(image: UIImage(named: "lokoBack"))
               backgroundImage.contentMode = .scaleAspectFill
               mainView.addSubview(backgroundImage)

      
               backgroundImage.snp.makeConstraints { make in
                   make.edges.equalToSuperview()
               }
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(regButton)
        stack.addArrangedSubview(enterButton)
        stack.addArrangedSubview(idButton)
        stack.alignment = .center
        stack.spacing = 30
        view.addSubview(stack)
 
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
          //  make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(250)
        }
        
        idButton.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(70)
        }
    }
}
