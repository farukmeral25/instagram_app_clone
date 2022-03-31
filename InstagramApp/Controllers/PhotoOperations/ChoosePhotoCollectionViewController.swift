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
    var selectedPhoto : UIImage?
    var assets = [PHAsset]()
    var header : PhotoSelectorHeaderCollectionViewCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        addButtons()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(ChoosePhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(PhotoSelectorHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        // Do any additional setup after loading the view.
        getPhotos()
    }
    
    fileprivate func getPhotosOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 20
        let sortOptions = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortOptions]
        return fetchOptions
    }
    
    fileprivate func getPhotos() {
        
        let photos = PHAsset.fetchAssets(with: .image, options: getPhotosOptions())
        DispatchQueue.global(qos: .background).async {
            photos.enumerateObjects { asset, number, stopPoint in
                
                //asset içinde tüm fotoğrafların bilgisi yer alır.
                //number'da kaçıncı fotoğraf getiriliyor
                //stopPoint fotoğraf getirilirken durulan noktanın adresini tutar
                let imageManager = PHImageManager.default()
                let imageSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                //Artık fetch limit değerine göre getirilecek.
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options) { image, imageInfo in
                    if let image = image {
                        self.assets.append(asset)
                        self.photos.append(image)
                        if self.selectedPhoto == nil {
                            self.selectedPhoto = image
                        }
                    }
                    
                    if number == photos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
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
        let sharePhotoViewController = SharePhotoViewController()
        sharePhotoViewController.selectedPhoto = header?.imageHeader.image
        navigationController?.pushViewController(sharePhotoViewController, animated: true)
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! PhotoSelectorHeaderCollectionViewCell
        self.header = header
        header.imageHeader.image = selectedPhoto
        
        if let selectedPhoto = selectedPhoto {
            if let index = self.photos.firstIndex(of: selectedPhoto){
                let seledtedAsset = self.assets[index]
                let photoManager = PHImageManager.default()
                let size = CGSize(width: 800, height: 800)
                photoManager.requestImage(for: seledtedAsset, targetSize: size, contentMode: .default, options: nil) { photo, info in
                    header.imageHeader.image = photo
                }
            }
        }
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhoto = photos[indexPath.row]
        collectionView.reloadData()
        let indexTop = IndexPath(item: 0,section: 0)
        collectionView.scrollToItem(at: indexTop, at: .bottom, animated: true)
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
