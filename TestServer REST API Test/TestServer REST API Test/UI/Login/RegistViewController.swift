//
//  RegistViewController.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/23.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var registData = UserData(username: nil, password: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registButtonClick(_ sender: Any) {
        registUser()
    }
    
    func registUser() {
        self.registData.username = self.usernameTextField.text
        self.registData.password = self.passwordTextField.text
        
        Network.shared.request(api: .regist, method: .post, parameters: registData.self) { (err) in
            if let err = err {
                print("Error getting Regist: \(err)")
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "회원가입", message: "회원가입이 완료되었습니다", preferredStyle: .alert)
                    
                    let okButton = UIAlertAction(title: "확인", style: .default) { (_) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    alertController.addAction(okButton)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
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
