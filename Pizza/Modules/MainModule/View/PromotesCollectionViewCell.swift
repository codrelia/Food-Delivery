import UIKit

class PromotesCollectionViewCell: UICollectionViewCell {

    // MARK: - UIViews
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

}

// MARK: - Private methods

private extension PromotesCollectionViewCell {
    func configureCell() {
        backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10


    }
}
