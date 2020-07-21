//
//  ContentViewController.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/21.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var data = TestData(id: nil, title: nil, content: nil, user: nil, time: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLabel.text = data.user! + " | " + data.time!
        titleLabel.text = data.title
        contentLabel.text = data.content
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
