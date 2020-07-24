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
    
    func login() {
        self.loginUser.username = self.loginTextField.text
        self.loginUser.password = self.passwordTextField.text
        
        Network.shared.request(api: .login, method: .post, parameters: loginUser.self) { (err) in
            if let err = err {
                print("Error getting Login: \(err)")
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
    
    @IBAction func loginButtonClick(_ sender: Any) {
        self.login()
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
