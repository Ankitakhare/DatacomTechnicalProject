//
//  SpyApiManager.swift
//  Album_iosTests
//
import Foundation
@testable import Album_ios

class SpyApiManager: ApiManagerProtocol {

    var invokedFetchAlbumsList = false
    var invokedFetchAlbumsListCount = 0
    var stubbedFetchAlbumsListCompletionResult: ([AlbumTitleModel]?, Error?)?

    func fetchAlbumsList(completion: @escaping ([AlbumTitleModel]?, Error?) -> Void) {
        invokedFetchAlbumsList = true
        invokedFetchAlbumsListCount += 1
        if let result = stubbedFetchAlbumsListCompletionResult {
            completion(result.0, result.1)
        }
    }

    var invokedFetchUserDetail = false
    var invokedFetchUserDetailCount = 0
    var stubbedFetchUserDetailCompletionResult: ([AlbumUserModel]?, Error?)?

    func fetchUserDetail(completion: @escaping ([AlbumUserModel]?, Error?) -> Void) {
        invokedFetchUserDetail = true
        invokedFetchUserDetailCount += 1
        if let result = stubbedFetchUserDetailCompletionResult {
            completion(result.0, result.1)
        }
    }

    var invokedFetchPhotos = false
    var invokedFetchPhotosCount = 0
    var invokedFetchPhotosParameters: (albumId: Int, Void)?
    var invokedFetchPhotosParametersList = [(albumId: Int, Void)]()
    var stubbedFetchPhotosCompletionResult: ([AlbumImageModel], Void)?

    func fetchPhotos(albumId: Int, completion: @escaping ([AlbumImageModel]) -> Void) {
        invokedFetchPhotos = true
        invokedFetchPhotosCount += 1
        invokedFetchPhotosParameters = (albumId, ())
        invokedFetchPhotosParametersList.append((albumId, ()))
        if let result = stubbedFetchPhotosCompletionResult {
            completion(result.0)
        }
    }
}
