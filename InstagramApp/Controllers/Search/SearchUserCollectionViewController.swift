//
//  SearchUserCollectionViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 3.04.2022.
//

import UIKit



class SearchUserCollectionViewController: UICollectionViewController {

    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter username"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.convertRGBA(red: 230, green: 230, blue: 230)
        return searchBar
    }()
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        searchBar.anchor(top: navBar?.topAnchor, bottom: navBar?.bottomAnchor, leading: navBar?.leadingAnchor, trailing: navBar?.trailingAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: -10, width: 0, height: 0)
        
        collectionView.register(SearchUserCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.alwaysBounceVertical = true
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        return cell
    }

}
