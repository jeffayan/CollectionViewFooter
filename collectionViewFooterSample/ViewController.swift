//
//  ViewController.swift
//  collectionViewFooterSample
//
//  Created by Developer on 11/08/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var collectionView : UICollectionView!
    
    let footerId = "footer"
    let cellId = "cellId"
    
    private var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //collectionView.register(UINib(nibName: "ReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
        
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! collectionCell
        cell.imageViewCell.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! CollectionReusableView
            cell.imageView.image = #imageLiteral(resourceName: "image")
            return cell
            
            
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.height)
    }
    
    
    @IBAction private func getImagesClick(_ sender: UIButton) {
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 10
        
        
        
        bs_presentImagePickerController(vc, animated: true,
        select: { (asset: PHAsset) -> Void in
          //  print("\n\nSelected: \(asset.)")
        }, deselect: { (asset: PHAsset) -> Void in
           // print("\n\nDeselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
           // print("\n\nCancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in
            print("\n\nFinish: \(assets)")
            
            let manager = PHImageManager()
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            let size = CGSize(width: 100, height: 100)
            for asset in assets {
                
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options, resultHandler: { image, info in
                    DispatchQueue.main.async {
                        
                        self.imageArray.append(image!)
                        
                        self.collectionView.reloadData()
                        
                    }
                   
                    
                })
                
            }
            
            
        }, completion: nil)
        
        
    }
     
    
}


class collectionCell : UICollectionViewCell{
    
    
    @IBOutlet var imageViewCell: UIImageView!
    
}

