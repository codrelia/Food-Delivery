import Foundation

class NetworkService {
    let url = "https://apex.oracle.com/pls/apex/dashashevchenkoapps/testapi/"
    
    enum path {
        case all
        
        var catalog: String {
            switch self {
            case .all:
                return "products"
            }
        }
    }
    
    func request(path: path, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let urlForRequest = URL(string: url + path.catalog) else {
            return
        }
        let task = URLSession.shared.dataTask(with: urlForRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
