import Foundation
import UIKit

class AlbumViewModel {
    
    let apiManager: ApiManagerProtocol
    let internetChecker: InternetCheckerProtocol
    
    init(apiManager: ApiManagerProtocol = ApiManager(),
         internetChecker: InternetCheckerProtocol = InternetChecker()) {
        self.apiManager = apiManager
        self.internetChecker = internetChecker
    }
    
    var userList = [AlbumUserModel]()
    var AlbumList = [AlbumTitleModel]()
    var arrayImageList = [AlbumImageModel]()
    var reloadTableView: ((String?) -> Void)?
    
    func fetchUserDetail() {
        if internetChecker.isInternetAvailable() {
            apiManager.fetchUserDetail() { [weak self] arrAlbums, error in
                guard let arrayAlbumsList = arrAlbums else { return }
                self?.userList.append(contentsOf: arrayAlbumsList)
                self?.fetchAlbumsList()
            }
        }
    }
    
    func fetchAlbumsList() {
        if internetChecker.isInternetAvailable() {
            apiManager.fetchAlbumsList() { [weak self] arrAlbums, error in
                guard let arrayAlbumsList = arrAlbums else {
                    
                    return
                }
                self?.AlbumList.append(contentsOf: arrayAlbumsList)
                self?.reloadTableView?(nil)
            }
        }
    }
    
    func fetchPhotos(albumId: Int) {
        if internetChecker.isInternetAvailable() {
            apiManager.fetchPhotos(albumId: albumId) { [weak self] (arrayImageList) in
                let album = arrayImageList.filter({ $0.albumId == albumId})
                self?.arrayImageList.append(contentsOf: album)
                self?.reloadTableView?(nil)
            }
        }
    }
    
    func getUserName(for userId: Int) -> String {
        let user = self.userList.first(where: { $0.id == userId})
        
        return user?.name ?? ""
    }
}


