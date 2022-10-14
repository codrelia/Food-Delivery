import Foundation
import UIKit

class FiltersCollection: UICollectionView {
    
    // MARK: - Properties
    
    var items: [String] = []
    var scrollView = UIScrollView()
    var filtersOutput: FiltersOutput?
    
    // MARK: - Initialization
    
    init(_ items: [String], _ frame: CGRect) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        self.items = items
        self.frame = frame
        
        self.setupCells()
        self.configureCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setOutput(filtersOutput: FiltersOutput) {
        self.filtersOutput = filtersOutput
    }
    
    func copyFilters(isTapped: Bool) -> FiltersCollection {
        let copy = FiltersCollection(items, frame)
        let activeCell = self.indexPathsForSelectedItems![0]
        copy.scrollToItem(at: activeCell, at: .centeredHorizontally, animated: false)
        copy.backgroundColor = .clear
        copy.selectItem(at: activeCell, animated: false, scrollPosition: .centeredHorizontally)
        if !isTapped {
            copy.contentOffset = scrollView.contentOffset
        }
        return copy
    }
    
    func changeTheProperties(_ copy: FiltersCollection, isTapped: Bool) {
        let activeCell = copy.indexPathsForSelectedItems![0]
        scrollToItem(at: activeCell, at: .centeredHorizontally, animated: false)
        selectItem(at: activeCell, animated: false, scrollPosition: .centeredHorizontally)
        if !isTapped {
            contentOffset = copy.scrollView.contentOffset
        }
    }
    
}

// MARK: - Private methods

private extension FiltersCollection {
    func configureCollection() {
        dataSource = self
        delegate = self
        
        showsHorizontalScrollIndicator = false
    }
    
    func setupCells() {
        self.register(UINib(nibName: "\(FiltersCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(FiltersCollectionViewCell.self)")
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FiltersCollection: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "\(FiltersCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? FiltersCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        cell.name = items[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = items[indexPath.row]
        label.sizeToFit()
        label.frame = CGRect(x: 0, y: 0, width: label.frame.width + 23, height: label.frame.height + 4)
        return CGSize(width: label.frame.width, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        guard let cell = collectionView.cellForItem(at: indexPath) as? FiltersCollectionViewCell else {
            return
        }
        filtersOutput?.scrollToRowFromFilters(name: cell.name)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
    
    
    
    
    
}

