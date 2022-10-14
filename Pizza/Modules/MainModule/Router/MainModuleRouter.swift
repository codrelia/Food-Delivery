import Foundation
import UIKit

class MainModuleRouter {
    // MARK: - VIPERs elements
    
    private var view: MainModuleViewController
    private var presenter: MainModulePresenter?
    
    // MARK: - Initialization
    
    init() {
        view = MainModuleViewController()
        presenter = MainModulePresenter(viewInput: view)
        view.setViewOutput(viewOutput: presenter!)
    }
    
    // MARK: - Getters
    
    func getView() -> UIViewController {
        return view
    }
}
