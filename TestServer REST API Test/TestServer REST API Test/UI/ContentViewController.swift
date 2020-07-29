//
//  ContentViewController.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/21.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Alamofire

class ContentViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var contentId = 0
    var data = TestData(id: nil, title: nil, content: nil, user: nil, time: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("contentId: \(contentId)")
//        userLabel.text = data.user! + " | " + data.time!
//        titleLabel.text = data.title
//        contentLabel.text = data.content
        getContent(contentId)
    }

    func getContent(_ id: Int) {
        Network.shared.response(api: .getData, method: .get, parameters: contentId) { (response: TestData) in
            print("responseData: \(response)")
            self.data = response
            
            DispatchQueue.main.async {
                self.userLabel.text = self.data.user! + " | " + self.data.time!
                self.titleLabel.text = self.data.title
                self.contentLabel.text = self.data.content
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
