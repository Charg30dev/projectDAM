//
//  CustomSerieTableViewCell.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import UIKit

class CustomSerieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSeries: UIImageView!
    @IBOutlet weak var titleSerie: UILabel!
    @IBOutlet weak var descriptionSerie: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
