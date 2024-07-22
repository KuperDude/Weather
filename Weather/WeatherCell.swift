//
//  WeatherCell.swift
//  Weather
//
//  Created by MyBook on 19.07.2024.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTitle: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    
    var action: (()->Void)?
    
    func configure(image: UIImage, title: String, action: (()->Void)?) {
        weatherImage.image = image
        weatherTitle.text = title
        self.action = action
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewPressed(_:))))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        addGradient()
    }

    private func setupViews() {
        weatherImage.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        layer.shadowColor = UIColor.background.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 5
    }
    
    private func addGradient() {
        gradientView.applyGradient(isVertical: true, colorArray: [
            UIColor.background.withAlphaComponent(0),
            UIColor.background.withAlphaComponent(0.4),
        ])
    }
    
    @objc private func viewPressed(_ sender: UITapGestureRecognizer) {
        HapticManager.shared.selection()
        action?()
    }
}
