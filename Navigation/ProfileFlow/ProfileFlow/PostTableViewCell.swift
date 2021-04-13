
import UIKit

protocol PostTableViewCellDelegate: class {
    func showDataNotFoundAlert(with title: String, with message: String)
    func showNetworkConnectionProblemAlert(with title: String, with message: String)
}

class PostTableViewCell: UITableViewCell {
    
    weak var delegate: PostTableViewCellDelegate?
    
    private let authorName: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.toAutoLayout()
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(urlImage: String) {
        guard let url = URL(string: urlImage) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, responce, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self?.alertError(error: .networkConnectionProblem)
                    self?.postImageView.image = nil
                }
                
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.postImageView.image = image
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func alertError(error: ApiError) {
        switch  error {
        case .dataNotFound:
            let title = "Data not found"
            let message = "Check URL"
            delegate?.showDataNotFoundAlert(with: title, with: message)
        case .networkConnectionProblem:
            let title = "Network connection problem"
            let message = "Check your network connection"
            delegate?.showNetworkConnectionProblemAlert(with: title, with: message)
            
        }
    }
    
    func configure(with viewModel: PostTableViewCellViewModel) {
        authorName.text = viewModel.author
        descriptionLabel.text = viewModel.description
        likesLabel.text = "Likes: \(viewModel.likes)"
        viewsLabel.text = "Views: \(viewModel.view)"
        loadImage(urlImage: viewModel.image)
    }
    
    private func setupLayout() {
        contentView.addSubview(authorName)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)

        let constraints = [
            
            authorName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 16),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

