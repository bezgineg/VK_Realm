
import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.backgroundColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configure(image: UIImage?) {
        photoImageView.image = image
    }
    
    // MARK: - Private Methods
    
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




