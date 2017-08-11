//
//  CollectionReusableView.swift
//  collectionViewFooterSample
//
//  Created by Developer on 11/08/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    lazy var imageView : UIImageView = {
       
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageClick(sender:)))
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        self.addSubview(imageView)
        
        return imageView
    }()

    
    @IBAction private func imageClick(sender: UITapGestureRecognizer){
        
        print("Clicked")
    }
    
}
