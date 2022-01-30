//
//  PhotosModel.swift
//  Navigation
//
//  Created by Евгений on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

protocol PhotosModelDelegate: AnyObject {
    func photosModel(_ photosModel: PhotosModel, showAlertWithTitle title: String, message: String)
}

protocol PhotosModel {
    var delegate: PhotosModelDelegate? { get set }
    
    func getCellImage(urlString: String, completion: @escaping (UIImage?) -> Void)
}

final class PhotosModelImpl: PhotosModel {
    
    // MARK: - Public Properties
    
    public weak var delegate: PhotosModelDelegate?
    
    // MARK: - Public Methods
    
    public func getCellImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        loadImage(urlImage: urlString) { [weak self] result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                self?.alertError(error: error)
                completion(nil)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func alertError(error: ApiError) {
        switch error {
        case .dataNotFound:
            let title = ApiErrorLocalization.dataNotFoundTitle.localizedValue
            let message = ApiErrorLocalization.dataNotFoundMessage.localizedValue
            delegate?.photosModel(self, showAlertWithTitle: title, message: message)
        case .networkConnectionProblem:
            let title = ApiErrorLocalization.networkConnectionProblemTitle.localizedValue
            let message = ApiErrorLocalization.networkConnectionProblemMessage.localizedValue
            delegate?.photosModel(self, showAlertWithTitle: title, message: message)
        }
    }
    
    private func loadImage(urlImage: String, completion: @escaping (Result<UIImage, ApiError>) -> Void) {
        guard let url = URL(string: urlImage) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                
                DispatchQueue.main.async {
                    completion(.failure(.dataNotFound))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        dataTask.resume()
    }
    
}
