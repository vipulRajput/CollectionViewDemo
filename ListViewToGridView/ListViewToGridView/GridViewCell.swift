//
//  GridViewCell.swift
//  ListViewToGridView
//
//  Created by Appinventiv on 28/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class GridViewCell: UICollectionViewCell {

    @IBOutlet weak var showingGridImage: UIImageView!
    @IBOutlet weak var showingGridImageName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populatedData(_ information: [String:String]) {
        let imageInfo = information["ImageUrl"]
        showingGridImage.backgroundColor = UIColor(patternImage: UIImage(named: imageInfo!)!)
        showingGridImageName.text = information["ImageName"]
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = nil
    }
    
}
