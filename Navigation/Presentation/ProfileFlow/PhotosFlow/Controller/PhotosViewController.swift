
import UIKit

final class PhotosViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var coordinator: PhotosCoordinator?
    
    // MARK: - Private Properties
    
    private let mainView = PhotosView()
    private let baseInset: CGFloat = 8
    private var model: PhotosModel
    
    // MARK: - Initializers
    
    init(model: PhotosModel = PhotosModelImpl()) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.didFinishPhotos()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = PhotosFlowLocalization.photosTitle.localizedValue
    }
    
    private func setDelegates() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        model.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return PhotosStorage.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotosStorage.photos[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
            for: indexPath
        ) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        
        let photo: Photo = PhotosStorage.photos[indexPath.section][indexPath.row]
        model.getCellImage(urlString: photo.image) { image in
            cell.configure(image: image)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat = (collectionView.frame.size.width - baseInset * 4) / 3
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return baseInset
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return baseInset
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: baseInset, left: baseInset, bottom: .zero, right: baseInset)
    }
}

// MARK: - PhotosModelDelegate

extension PhotosViewController: PhotosModelDelegate {
    func photosModel(_ photosModel: PhotosModel, showAlertWithTitle title: String, message: String) {
        coordinator?.showAlert(with: title, with: message)
    }
}
