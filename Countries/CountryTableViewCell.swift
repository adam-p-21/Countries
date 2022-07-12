//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Adam Paluszewski on 29/06/2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countryView.layer.cornerRadius = 10
        countryView.layer.opacity = 0.90
        
        countryView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        
        
        countryNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.countryView.backgroundColor = UIColor.lightGray
                self.countryView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
//                self.countryFlagImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.countryFlagImageView.transform = CGAffineTransform(scaleX: 10, y: 10)
                self.countryView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { finished in
                self.countryView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
                self.countryFlagImageView.transform = .identity
            }
            
        } else {
            
        }
        
    }

}
