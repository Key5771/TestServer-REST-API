//
//  LoginViewController.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/22.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var loginUser = UserData(username: nil, password: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func loginError() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "로그인 실패", message: "아이디 또는 패스워드를 확인해주세요", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func login() {
        if loginTextField.text == "" || passwordTextField.text == "" {
            print("loginData nil")
            loginError()
        } else {
            self.loginUser.username = self.loginTextField.text
            self.loginUser.password = self.passwordTextField.text
            
            Network.shared.request(api: .login, method: .post, parameters: loginUser.self) { (nil, err) in
                if let err = err {
                    print("Error getting Login: \(err)")
                    self.loginError()
                } else {
                    DispatchQueue.main.async {
                        let viewController = self.storyboard?.instantiateViewController(identifier: "navigation")
                        viewController?.modalPresentationStyle = .fullScreen
                        
                        guard let vc = viewController else { return }
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        login()
    }
    
    @IBAction func registButtonClick(_ sender: Any) {
        let vc = RegistViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
