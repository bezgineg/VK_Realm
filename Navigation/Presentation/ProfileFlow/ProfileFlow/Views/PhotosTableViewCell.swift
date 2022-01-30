import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var counter = 10
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setupLabel()
        return label
    }()
    
    private let arrowLabel: UILabel = {
        let label = UILabel()
        label.setupLabel()
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ProfileFlowLocalization.timerLabel.localizedValue) 10 \(ProfileFlowLocalization.seconds.localizedValue)"
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let firstImage: UIImageView = {
        let image = UIImageView()
        image.setupImages()
        return image
    }()
    
    private let secondImage: UIImageView = {
        let image = UIImageView()
        image.setupImages()
        return image
    }()
    
    private let thirdImage: UIImageView = {
        let image = UIImageView()
        image.setupImages()
        return image
    }()
    
    private let fourthImage: UIImageView = {
        let image = UIImageView()
        image.setupImages()
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.addArrangedSubview(firstImage)
        stackView.addArrangedSubview(secondImage)
        stackView.addArrangedSubview(thirdImage)
        stackView.addArrangedSubview(fourthImage)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.layer.borderColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black).cgColor
        stackView.backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        return stackView
    }()
    
    private let imageWidth: CGFloat = {
        let screenSize: CGRect = UIScreen.main.bounds
        let imageWidth = (screenSize.width - 48) / 4
        return imageWidth
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func updateReloadingInfo() {
        counter -= 1
        timerLabel.text = "\(ProfileFlowLocalization.timerLabel.localizedValue) \(counter) \(ProfileFlowLocalization.seconds.localizedValue)"

        if counter == 1 {
            counter = 11
        } else if counter == 10 {
            titleLabel.textColor = UIColor(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1
            )
        }
    }
    
    public func configure(with viewModel: PhotosTableViewCellViewModel) {
        titleLabel.text = viewModel.titleLabel
        arrowLabel.text = viewModel.arrowLabel
        firstImage.image = viewModel.firstImage
        secondImage.image = viewModel.secondImage
        thirdImage.image = viewModel.thirdImage
        fourthImage.image = viewModel.fourthImage
        setupPhotos(with: viewModel)
    }
    
    private func setupPhotos(with model: PhotosTableViewCellViewModel) {
        let photosQueue = DispatchQueue(label: "photosQueue", qos: .unspecified, attributes: .concurrent)
        
        photosQueue.async { [weak self] in
            guard let self = self else { return }
            if let secondImage = model.secondImage { 
                model.useColorInvertFilter(image: secondImage) { image in
                    DispatchQueue.main.async {
                        self.secondImage.image = image
                    }
                }
            }
            
            if let firstImage = model.firstImage {
                model.useNoirFilter(image: firstImage) { image in
                    DispatchQueue.main.async {
                        self.firstImage.image = image
                    }
                }
            }
            
            if let thirdImage = model.thirdImage {
                model.useFadeFilter(image: thirdImage) { image in
                    DispatchQueue.main.async {
                        self.thirdImage.image = image
                    }
                }
            }
            
            if let fourthImage = model.fourthImage {
                model.useChromeFilter(image: fourthImage) { image in
                    DispatchQueue.main.async {
                        self.fourthImage.image = image
                    }
                }
            }
        }
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        contentView.addSubview(timerLabel)
        contentView.addSubview(stackView)
        
        let constraints = [
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            timerLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: imageWidth),
            stackView.widthAnchor.constraint(equalToConstant: imageWidth)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
 }


