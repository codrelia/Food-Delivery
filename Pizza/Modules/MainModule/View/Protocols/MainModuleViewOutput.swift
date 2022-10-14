import Foundation

protocol MainModuleViewOutput: AnyObject {
    func getRequestForAllProducts()
    func getAllProducts() -> Info?
    func getCountOfProducts() -> Int
    func getCountCellsHigher(_ section: Int) -> Int
    func defineCategory(_ id: Int) -> Int
}
