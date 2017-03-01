//
//  ListViewCell.swift
//  ListViewToGridView
//
//  Created by Appinventiv on 28/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ListViewCell: UICollectionViewCell{

    @IBOutlet weak var showingListImage: UIImageView!
    
    @IBOutlet weak var showingListImageName: UILabel!
    
    override func awakeFromNib() {
    
        super.awakeFromNib()
            // Initialization code
    }
    
    func populatedData(_ information: [String:String]) {
        
        let imageInfo = information["ImageUrl"]
        
        showingListImage.backgroundColor = UIColor(patternImage: UIImage(named: imageInfo!)!)
        
        showingListImageName.text = information["ImageName"]
    
    }
}


