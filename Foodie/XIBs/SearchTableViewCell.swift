//
//  SearchTableViewCell.swift
//  Foodie
//
//  Created by surya-zstk231 on 21/09/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var locationIconView: UIImageView!
    @IBOutlet var locationSubName: UILabel!
    @IBOutlet var locationName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bootCell(name: String, subName: String) {
        self.locationName.text = name
        self.locationSubName.text = subName
        self.locationIconView.image = UIImage(named: "LocationIcon")
    }
    
}
