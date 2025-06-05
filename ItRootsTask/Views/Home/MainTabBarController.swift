//
//  Home.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!

    let horizontalItems = Array(1...10).map { "H Item \($0)" }
    let verticalItems = Array(1...20).map { "V Item \($0)" }

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self

        horizontalCollectionView.collectionViewLayout = createHorizontalLayout()
        verticalCollectionView.collectionViewLayout = createVerticalLayout()
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return horizontalItems.count
        } else {
            return verticalItems.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath)
            if let label = cell.contentView.viewWithTag(100) as? UILabel {
                label.text = horizontalItems[indexPath.item]
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell", for: indexPath)
            if let label = cell.contentView.viewWithTag(101) as? UILabel {
                label.text = verticalItems[indexPath.item]
            }
            return cell
        }
    }
}
