//
//  ListViewController.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/20.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Alamofire
import SwipeCellKit

class ListViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let refreshControl = UIRefreshControl()
    
    var test: [TestData] = []
    var reuseIdentifier = "listCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupUI()
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    private func setupUI() {
        let nibName = UINib(nibName: String(describing: ListCollectionViewCell.self), bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "listCell")

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func loadData() {
        Network.shared.response(api: .getData, method: .get) { (response: Data) in
            self.test = response.data
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
        
        refreshControl.endRefreshing()
    }

    @IBAction func addButtonClick(_ sender: Any) {
        let vc = AddViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        let dequeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let cell = dequeCell as? ListCollectionViewCell else { return dequeCell }
        
        cell.delegate = self
        
        cell.titleLabel.text = test[indexPath.row].title
        cell.contentLabel.text = test[indexPath.row].content
        cell.userLabel.text = test[indexPath.row].user! +  " | " + test[indexPath.row].time!
        
        return cell
    }
    
    
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = ContentViewController()
//        vc.data = test[indexPath.row]
        
        guard let id = test[indexPath.row].id else { return }
        vc.contentId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let height = width * 4 / 16
        return CGSize(width: width, height: height)
    }
}

extension ListViewController: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.test.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            action.fulfill(with: .delete)
        }
        
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    
}
