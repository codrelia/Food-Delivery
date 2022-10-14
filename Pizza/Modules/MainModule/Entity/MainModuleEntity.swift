import Foundation
import UIKit

// MARK: - Info
struct Info: Codable {
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let name: String
    let idCategory: Int
    let itemDescription: String?
    let minSum: Int
    let urlImage: String
    let nameCategory: [NameCategory]
    
    var image: UIImage?

    enum CodingKeys: String, CodingKey {
        case id, name, idCategory
        case itemDescription = "description"
        case minSum, urlImage, nameCategory
    }
}

// MARK: - NameCategory
struct NameCategory: Codable {
    let nameCategory: String
}
