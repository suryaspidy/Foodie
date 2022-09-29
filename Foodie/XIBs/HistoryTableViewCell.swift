//
//  HistoryTableViewCell.swift
//  Foodie
//
//  Created by surya-zstk231 on 18/09/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet var fromLocationName: UILabel!
    @IBOutlet var fromLocationSubName: UILabel!
    @IBOutlet var toLocationName: UILabel!
    @IBOutlet var toLocationSubName: UILabel!
    @IBOutlet var historyLocationImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateValue(frmoLocationName: String?, frmoSubLocationName: String?,toLocationName: String?, toSubLocationName: String?) {
        self.fromLocationName.text = frmoLocationName
        self.fromLocationSubName.text = frmoSubLocationName
        self.toLocationName.text = toLocationName
        self.toLocationSubName.text = toSubLocationName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
