
import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var coordinator: FeedCoordinator?
    
    // MARK: - Private Properties
    
    private let mainView = FeedView()
    private let storageManager: DataStorageProtocol
    
    // MARK: - Initializers
    
    init(storageManager: DataStorageProtocol = CoreDataManager.manager)  {
        self.storageManager = storageManager
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
        
        navigationItem.title = TabBarLocalization.feed.localizedValue
        setDelegates()
    }
    
    // MARK: - Private Methods
    
    private func setDelegates() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func addPostToFavorites(post: Post) {
        let context = storageManager.getBackgroundContext()
        let favoritePost = storageManager.createObject(from: FavoritePost.self, context: context)
        favoritePost.author = post.author
        favoritePost.descript = post.description
        favoritePost.image = post.image?.pngData()
        favoritePost.likes = Int64(post.likes)
        favoritePost.views = Int64(post.view)
        storageManager.save(context: context)
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedStorage.feed.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FeedTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: FeedTableViewCell.self),
            for: indexPath
        ) as? FeedTableViewCell else { return UITableViewCell() }
        let post = FeedStorage.feed[indexPath.row]
        cell.configure(with: post, index: indexPath.row)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.pushPostVC(author: AuthorStorage.authors[indexPath.row])
    }
}

// MARK: - FeedTableViewCellDelegate

extension FeedViewController: FeedTableViewCellDelegate {
    func feedTableViewCell(
        _ feedTableViewCell: FeedTableViewCell,
        addButtonTappedByIndex index: Int,
        button: UIButton
    ) {
        let post = FeedStorage.feed[index]
        coordinator?.showMoreInfoScreen(post: post, button: button, delegate: self)
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension FeedViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - MoreInfoViewControllerDelegate

extension FeedViewController: MoreInfoViewControllerDelegate {
    func moreInfoViewController(_ moreInfoViewController: MoreInfoViewController, hidePost post: Post?) {
        if let index = FeedStorage.feed.firstIndex(where: { $0.author == post?.author }) {
            FeedStorage.feed.remove(at: index)
            mainView.tableView.reloadData()
        }
    }
    
    func moreInfoViewController(_ moreInfoViewController: MoreInfoViewController, addPost post: Post?) {
        guard let post = post else { return }
        addPostToFavorites(post: post)
        coordinator?.showAlert(with: AlertLocalization.profileAlertTitle.localizedValue, with: "")
    }
}
