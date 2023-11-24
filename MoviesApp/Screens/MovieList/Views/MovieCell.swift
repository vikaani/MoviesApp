//
//  MovieCell.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    var onTapFavoriteButton: (() -> Void)?
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        if sender.currentImage == .heartImage {
            sender.setImage(.heartFillImage, for: .normal)
        } else {
            sender.setImage(.heartImage, for: .normal)
        }
        onTapFavoriteButton?()
    }
    
    func setFavoriteButton(isFavorited: Bool) {
        let favoriteButtonImage: UIImage = isFavorited ? .heartFillImage : .heartImage
        
        favoriteButton.setImage(favoriteButtonImage, for: .normal)
    }
}




