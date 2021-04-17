/*
 * Copyright 2021 Auro
 * Name of the module - ImageList
 * Created date - 17/04/21
 * Created by - Krishna Kirana
 * Synopsis - Image List Table view cell for displaying
 */

import UIKit
import Kingfisher

class ImageListTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var tableView: UITableView?
    var movieDetails: MovieDetails! {
        didSet {
            self.updateCellDetails()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     Start the download process
     */
    private func updateCellDetails() {
        titleLabel.text = self.movieDetails.title
        if let url = URL(string: self.movieDetails.generatePosterPathUrl()) {
            photoImageView.kf.setImage(with: url)
        }
    }
}
