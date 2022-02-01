
import UIKit

final class PostViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var coordinator: PostCoordinator?
    
    // MARK: - Private Properties
    
    private let author: Author
    private let mainView = PostView()
    private let baseInset: CGFloat = 16
    
    // MARK: - Initializers
    
    init(author: Author)  {
        self.author = author
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
        
        navigationItem.title = author.name
        setDelegates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.didFinishPost()
    }
    
    // MARK: - Private Methods

    private func setDelegates() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PostViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urlString = author.urlStrings[indexPath.item]
        print(urlString)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: UIDevice.hasNotch ? 85 : 105,
            left: baseInset,
            bottom: UIDevice.hasNotch ? 80 : 113,
            right: baseInset
        )
    }
}

// MARK: - UICollectionViewDataSource

extension PostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return author.urlStrings.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PostCollectionViewCell.self),
            for: indexPath
        ) as? PostCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(index: indexPath.item, author: author)
        cell.delegate = self
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = (view.bounds.width - (baseInset * 3)) / 2
        return CGSize(width: size, height: size)
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
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return baseInset
    }
}

// MARK: - PostCollectionViewCellDelegate

extension PostViewController: PostCollectionViewCellDelegate {
    func postCollectionViewCell(_ postCollectionViewCell: PostCollectionViewCell, showMoreButtonTappedAt index: Int) {
        print(index)
    }
}
