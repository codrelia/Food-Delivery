//
//  FiltersTableViewCell.swift
//  Pizza
//
//  Created by Дарья Шевченко on 14/10/2022.
//

import UIKit

class FiltersTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    var collectionView: FiltersCollection?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}

// MARK: - Private methods

private extension FiltersTableViewCell {
    func configureCell() {
        collectionView = FiltersCollection(["Пицца", "Комбо", "Десерты", "Напитки", "Другие товары"], CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 56))
        collectionView!.dataSource = collectionView
        collectionView!.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
        collectionView!.collectionView(collectionView!, didSelectItemAt: IndexPath(item: 0, section: 0))
        addSubview(collectionView!)
        
        backgroundColor = .clear
        collectionView?.backgroundColor = .clear
        
        separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
    }
}

