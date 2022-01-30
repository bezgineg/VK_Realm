
import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var coordinator: FeedCoordinator?
    
    // MARK: - Private Properties
    
    private let mainView = FeedView()
    
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
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
