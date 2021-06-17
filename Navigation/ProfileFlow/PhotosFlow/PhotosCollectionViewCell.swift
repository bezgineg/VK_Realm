
import UIKit

protocol PhotosTableViewCellDelegate: class {
    func showDataNotFoundAlert(with title: String, with message: String)
    func showNetworkConnectionProblemAlert(with title: String, with message: String)
}

class PhotosCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: PhotosTableViewCellDelegate?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.backgroundColor = .black
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(urlImage: String, completion: @escaping (Result<[UIImage], ApiError>) -> Void) {
        guard let url = URL(string: urlImage) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, responce, error) in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                
                DispatchQueue.main.async {
                    completion(.failure(.dataNotFound))
                    self?.photoImageView.image = nil
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success([image]))
                self?.photoImageView.image = image
            }
            
        }
        
        dataTask.resume()
    }
    
    func configure(with model: Photo) {
        loadImage(urlImage: model.image) { result in
            switch result {
            case .success(let images):
                print("Image loaded: \(images)")
            case .failure(let error):
                self.alertError(error: error)
            }
        }
    }
    
    private func alertError(error: ApiError) {
        switch  error {
        case .dataNotFound:
            let title = ApiErrorLocalization.dataNotFoundTitle.localizedValue
            let message = ApiErrorLocalization.dataNotFoundMessage.localizedValue
            delegate?.showDataNotFoundAlert(with: title, with: message)
        case .networkConnectionProblem:
            let title = ApiErrorLocalization.networkConnectionProblemTitle.localizedValue
            let message = ApiErrorLocalization.networkConnectionProblemMessage.localizedValue
            delegate?.showNetworkConnectionProblemAlert(with: title, with: message)
        }
    }
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
        
        let constraints = [
            
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}




