import Foundation
import UIKit

enum APIError: LocalizedError {
    
    case responseInvalid
    case authorisationError(String)
    
    var errorDescription: String? {
        switch self {
        case .responseInvalid: return "The server response was invalid."
        case .authorisationError(let error): return "Failed Authorisation with service error: \(error)"
        }
    }
}

protocol ApiManagerProtocol {
    func fetchAlbumsList(completion: @escaping ([AlbumTitleModel]?, Error?) -> Void)
    func fetchUserDetail(completion: @escaping ([AlbumUserModel]?, Error?) -> Void)
    func fetchPhotos(albumId: Int, completion: @escaping ([AlbumImageModel]) -> Void)
}

class ApiManager: ApiManagerProtocol {
    
    func fetchAlbumsList(completion: @escaping ([AlbumTitleModel]?, Error?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"]))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let albums = try decoder.decode([AlbumTitleModel].self, from: data)
                completion(albums, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func fetchUserDetail(completion: @escaping ([AlbumUserModel]?, Error?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                
                return
            }
            guard let data = data else {
                completion(nil, APIError.responseInvalid)
                
                return
            }
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([AlbumUserModel].self, from: data)
                completion(users, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func fetchPhotos(albumId: Int, completion: @escaping ([AlbumImageModel]) -> Void) {
        let url = URL(string: "http://jsonplaceholder.typicode.com/photos?albumId=\(albumId)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let photos = try decoder.decode([AlbumImageModel].self, from: data)
                    completion(photos)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
