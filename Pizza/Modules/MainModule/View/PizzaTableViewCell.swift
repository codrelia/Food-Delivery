import UIKit

class PizzaTableViewCell: UITableViewCell {

    // MARK: - UIViews
    
    @IBOutlet private weak var imageOfProducts: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var coastButton: UIButton!
    
    // MARK: - Properties
    
    var image: UIImage? = UIImage() {
        didSet {
            imageOfProducts.image = image
        }
    }
    
    var name = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var descriptionText: String? = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func setButtonTitle(coast: Int, _ id: Int) {
        if id == 1 {
            coastButton.setTitle("от \(coast) р", for: .normal)
        } else {
            coastButton.setTitle("\(coast) р", for: .normal)
        }
    }
    
    
}

// MARK: - Private extension

private extension PizzaTableViewCell {
    func configureCell() {
        imageOfProducts.contentMode = .scaleAspectFill
        
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nameLabel.numberOfLines = 2
        nameLabel.textColor = .black
        
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = Colors.descriptionColor
        
        coastButton.layer.cornerRadius = 6.0
        coastButton.layer.borderWidth = 1.0
        coastButton.layer.borderColor = Colors.activeIconColor.cgColor
        coastButton.tintColor = Colors.activeIconColor
        coastButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        coastButton.setTitle("от 345 р", for: .normal)
        coastButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 18, bottom: 8, right: 18)
    }
}

