//
//  HomeViewController.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//

import Foundation
import UIKit
    

class HomeViewController: UIViewController {
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!

    let statusItems: [StatusItem] = [
        StatusItem(title: "Messages", value: "5"),
        StatusItem(title: "Tasks", value: "12/20"),
        StatusItem(title: "Status", value: "Verified"),
        StatusItem(title: "Network", value: "Online"),
        StatusItem(title: "Version", value: "1.0.3")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self

        horizontalCollectionView.collectionViewLayout = createHorizontalLayout()
        verticalCollectionView.collectionViewLayout = createVerticalLayout()
        setupNib()
        
    }
    
    private func setupNib() {
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        horizontalCollectionView.register(nib, forCellWithReuseIdentifier: "HomeCell")
        verticalCollectionView.register(nib, forCellWithReuseIdentifier: "HomeCell")
    }

    private func createHorizontalLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        return layout
    }

    private func createVerticalLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width - 20, height: 50)
        layout.minimumLineSpacing = 10
        return layout
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return statusItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
            let item = statusItems[indexPath.item]
               cell.configure(with: item)
            return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 120)
    }

}
