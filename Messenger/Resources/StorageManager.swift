//
//  StorageManager.swift
//  Messenger
//
//  Created by Leysan Latypova on 06.09.2022.
//

import Foundation
import FirebaseStorage

public enum StorageErrors: Error {
    case failedToUpload
    case failedToDowloadUrl
}

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    /// Uploads picture to firebase storage and  returns completion with url string to download
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil) { metadata, error in
            guard error == nil else {
                print("failed to upload data to firebase")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to download URL")
                    completion(.failure(StorageErrors.failedToDowloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        
        reference.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToDowloadUrl))
                return
            }
            completion(.success(url))
        }
    }
    /// Upload image that will be sent in the convo mssg
    public func uploadMessagePhoto(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("messegeImages/\(fileName)").putData(data, metadata: nil) { [weak self] metadata, error in
            guard error == nil else {
                print("failed to upload data to firebase")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("messegeImages/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to download URL")
                    completion(.failure(StorageErrors.failedToDowloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    /// Upload video that will be sent in the convo mssg
    public func uploadVideoMessage(with fileURL: URL, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("messegeVideos/\(fileName)").putFile(from: fileURL, metadata: nil) { [weak self] metadata, error in
            guard error == nil else {
                print("failed to upload video file to firebase")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("messegeVideos/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to download URL")
                    completion(.failure(StorageErrors.failedToDowloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
}
