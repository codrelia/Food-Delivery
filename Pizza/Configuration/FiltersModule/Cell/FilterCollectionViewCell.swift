import UIKit

class FiltersCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIViews

    @IBOutlet weak var nameInCollection: UILabel!
    
    // MARK: - Properties
    
    var name: String = "" {
        didSet {
            nameInCollection.text = name
        }
    }
    
    private var color: UIColor = .gray {
        didSet {
            nameInCollection.textColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
        backgroundColor = .clear
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                color = Colors.activeIconColor
                nameInCollection.font = .systemFont(ofSize: 13, weight: .bold)
                backgroundColor = Colors.activeIconColor.withAlphaComponent(0.2)
                layer.cornerRadius = 15
                layer.borderWidth = 0.0
            } else {
                color = Colors.activeIconColor.withAlphaComponent(0.4)
                nameInCollection.font = .systemFont(ofSize: 13, weight: .regular)
                backgroundColor = .clear
                layer.borderWidth = 1
                layer.cornerRadius = 15
                layer.borderColor = Colors.activeIconColor.withAlphaComponent(0.4).cgColor

            }
        }
    }
}

// MARK: - Private extension

private extension FiltersCollectionViewCell {
    func configureCell() {
        nameInCollection.font = .systemFont(ofSize: 13, weight: .medium)
        nameInCollection.textColor = .gray
    }
}
