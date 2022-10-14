import Foundation

class MainModulePresenter {
    
    // MARK: - VIPERs elements
    weak var viewInput: MainModuleViewInput?
    var interactorInput: MainModuleInteractorInput?
    
    // MARK: - Initialization
    
    init(viewInput: MainModuleViewInput) {
        self.viewInput = viewInput
        self.interactorInput = MainModuleInteractor(interactorOutput: self)
    }
}

// MARK: - MainModuleViewOutput

extension MainModulePresenter: MainModuleViewOutput {
    func getRequestForAllProducts() {
        interactorInput?.getRequestForAllProducts()
    }
    
    func getAllProducts() -> Info? {
        interactorInput?.getAllProducts()
    }
    
    func getCountOfProducts() -> Int {
        guard let interactorInput = interactorInput else {
            return 0
        }
        return interactorInput.getCountOfProducts()
    }
    
    func getCountCellsHigher(_ section: Int) -> Int {
        guard let interactorInput = interactorInput else {
            return 0
        }
        return interactorInput.getCountCellsHigher(section)
    }
    
    func defineCategory(_ id: Int) -> Int {
        interactorInput?.defineCategory(id) ?? 1
    }
}

// MARK: - MainModuleInteractorOutput

extension MainModulePresenter: MainModuleInteractorOutput {
    func reloadData() {
        viewInput?.reloadData()
    }
    
    
    
}
