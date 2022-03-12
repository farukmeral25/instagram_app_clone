//
//  ChoosePhotoCollectionViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 4.03.2022.
//

import UIKit
import Photos


class ChoosePhotoCollectionViewController: UICollectionViewController {
    let cellID = "cellID"
    let headerID = "headerID"
    var photos = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        
        addButtons()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(ChoosePhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        // Do any additional setup after loading the view.
        getPhotos()
    }
    
    fileprivate func getPhotos() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        let sortOptions = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortOptions]
        let photos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        photos.enumerateObjects { asset, number, stopPoint in
            
            //asset içinde tüm fotoğrafların bilgisi yer alır.
            //number'da kaçıncı fotoğraf getiriliyor
            //stopPoint fotoğraf getirilirken durulan noktanın adresini tutar
            let imageManager = PHImageManager.default()
            let imageSize = CGSize(width: 400, height: 400)
            let options = PHImageRequestOptions()
            //Artık fetch limit değerine göre getirilecek.
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options) { image, imageInfo in
                if let image = image {
                    self.photos.append(image)
                }
                
                if number == photos.count - 1 {
                    self.collectionView.reloadData()
                }
            }
        }
        
        print("Fotoğrafları Getir.")
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    fileprivate func addButtons(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:  #selector(buttonCancelPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(buttonNextPressed))
    }
    
    @objc func buttonCancelPressed(){
        dismiss(animated: true,completion: nil)
    }
    
    @objc func buttonNextPressed(){
        print("Sonraki Butonuna Basıldı.")
    }
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChoosePhotoCollectionViewCell
        //cell.backgroundColor = .brown
        cell.imageView.image = photos[indexPath.row]
    
        // Configure the cell
    
        return cell
    }
    
    //Header'ın oluşmasını tetikleyecek ve boyut ataması yapacak olan method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = (view.frame.width)
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        header.backgroundColor = .blue
        return header
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
