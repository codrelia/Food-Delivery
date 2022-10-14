import UIKit

class MainModuleViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        
    }
    
    // MARK: - UIViews
    
    @IBOutlet private weak var tableView: UITableView!
    private var copyFilters: UIView?
    private var filters: FiltersCollection?
    
    // MARK: - VIPERs elements
    
    var viewOutput: MainModuleViewOutput?
    
    // MARK: - Properties
    
    var isViewWithFilters = false
    var isTappedOnFilters = false
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
        configureNavigationBar()
        
        viewOutput?.getRequestForAllProducts()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Methods
    
    func setViewOutput(viewOutput: MainModuleViewOutput) {
        self.viewOutput = viewOutput
    }

}

// MARK: - Private methods

private extension MainModuleViewController {
    func configureView() {
        view.backgroundColor = Colors.backgroundColor
    }
    
    func configureTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "\(PromotesTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PromotesTableViewCell.self)")
        tableView.register(UINib(nibName: "\(FiltersTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(FiltersTableViewCell.self)")
        tableView.register(UINib(nibName: "\(PizzaTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PizzaTableViewCell.self)")
        
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
    }
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = createCustomButtonFromBarButtonItem(title: "Москва", image: "arrow", selector: #selector(leftButtonTapped), reverse: true)
        navigationController?.navigationBar.backgroundColor = Colors.backgroundColor
        navigationController?.navigationBar.barTintColor = Colors.backgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func leftButtonTapped(sender: UIButton) {
        print("Выбор города")
    }
    
    func createCustomButtonFromBarButtonItem(title: String, image: String, selector: Selector, reverse: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image), for: .normal)
        let titleString = reverse ?  title + " " : " " + title
        button.setTitle(titleString, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.tintColor = Colors.cityTextColor
        button.addTarget(self, action: selector, for: .touchUpInside)
        if reverse {
            button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        
        return barItem
    }
    
    func configureRoundedCell(cell: UITableViewCell) {
        let path = UIBezierPath(
            roundedRect: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: view.frame.width, height: cell.frame.height),
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 20, height:  20)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
    }
    
    func changingFiltersWhenMoving() -> IndexPath {
        let visibleCells = tableView.indexPathsForVisibleRows
        let lastCell = visibleCells!.last!.row - 3
        let category = viewOutput!.defineCategory(lastCell) - 1
        return IndexPath(row: category, section: 0)
    }
}

// MARK: - MainModuleViewInput

extension MainModuleViewController: MainModuleViewInput {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension MainModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewOutput = viewOutput else {
            return 0
        }
        return 3 + viewOutput.getCountOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PromotesTableViewCell.self)") else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FiltersTableViewCell.self)") as? FiltersTableViewCell else {
                return UITableViewCell()
            }
            cell.collectionView?.setOutput(filtersOutput: self)
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            configureRoundedCell(cell: cell)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PizzaTableViewCell.self)") as? PizzaTableViewCell else {
                return UITableViewCell()
            }
            guard let entity = viewOutput?.getAllProducts() else {
                return cell
            }
            
            let item = entity.items[indexPath.row - 3]
            
            cell.image = item.image
            cell.name = item.name
            cell.descriptionText = item.itemDescription
            cell.setButtonTitle(coast: item.minSum, item.idCategory)
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension MainModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150.0
        }
        else if indexPath.row == 1{
            return 52.0
        }
        else if indexPath.row == 2 {
            return 14.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = changingFiltersWhenMoving()
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? FiltersTableViewCell else {
            if !isTappedOnFilters {
                filters?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                filters?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            return
        }
        if !isTappedOnFilters {
            cell.collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            filters?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        let navigationViewHeight = navigationController!.navigationBar.frame.height
        let temp = navigationViewHeight + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20)
        
        if scrollView.contentOffset.y >= cell.frame.origin.y && !isViewWithFilters {
            copyFilters = UIView()
            copyFilters!.frame = CGRect(x: 0, y: temp, width: cell.frame.width, height: cell.frame.height)
            copyFilters!.backgroundColor = Colors.backgroundColor
            DispatchQueue.main.async {
                self.tableView.contentInset = UIEdgeInsets(top: self.copyFilters!.frame.height, left: 0, bottom: 0, right: 0)
            }
            filters = cell.collectionView!.copyFilters(isTapped: isTappedOnFilters)
            filters!.setOutput(filtersOutput: self)
            copyFilters!.addSubview(filters!)
            view.addSubview(copyFilters!)
            isViewWithFilters = true
            isTappedOnFilters = false
            
        } else if scrollView.contentOffset.y < cell.frame.origin.y && isViewWithFilters {
            copyFilters?.removeFromSuperview()
            if copyFilters != nil {
                cell.collectionView?.changeTheProperties(copyFilters!.subviews[0] as! FiltersCollection, isTapped: isTappedOnFilters)
            }
            isViewWithFilters = false
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    
    }
}

// MARK: - FiltersOutput

extension MainModuleViewController: FiltersOutput {
    func scrollToRowFromFilters(name: String) {
        var row = 0
        switch name {
        case "Пицца":
            row = 0
            break
        case "Комбо":
            row = 3 + viewOutput!.getCountCellsHigher(2)
            break
        case "Десерты":
            row = 3 + viewOutput!.getCountCellsHigher(3)
            break
        case "Напитки":
            row = 3 + viewOutput!.getCountCellsHigher(4)
            break
        case "Другие товары":
            row = 3 + viewOutput!.getCountCellsHigher(5)
            break
        default:
            row = 3
        }
        
        self.isTappedOnFilters = true
        var sum: CGFloat = 0.0
        for i in 0..<row {
            let indexPath = IndexPath(row: i, section: 0)
            let cell1 = self.tableView.cellForRow(at: indexPath)
            sum += cell1?.frame.height ?? 0.0
        }
        
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? FiltersTableViewCell
        
        if sum > view.frame.height {
            if cell == nil {
                self.tableView.contentInset = UIEdgeInsets(top: self.copyFilters!.frame.height, left: 0, bottom: 0, right: 0)
            } else {
                self.tableView.contentInset = UIEdgeInsets(top: cell!.frame.height, left: 0, bottom: 0, right: 0)
            }
        }
        
        self.tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .top, animated: true)
    }
}

