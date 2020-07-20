//
//  ListViewController.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/20.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var test: [TestData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        print("test count: \(test.count)")
    }
    
    func setupUI() {
        let nibName = UINib(nibName: String(describing: ListCollectionViewCell.self), bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "listCell")

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func loadData() {
        Network.shared.request(api: .get, method: .get) { (response: Data) in
            self.test = response.data
            self.collectionView.reloadData()
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

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCollectionViewCell
        
        cell.titleLabel.text = test[indexPath.row].title
        cell.contentLabel.text = test[indexPath.row].content
        cell.userLabel.text = test[indexPath.row].user
        cell.timeLabel.text = test[indexPath.row].time
        
        return cell
    }
    
    
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let height = width * 9 / 16 + 55.5
        return CGSize(width: width, height: height)
    }
}
