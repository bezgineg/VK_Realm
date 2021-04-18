
import UIKit

class FavoriteViewController: UIViewController {
    
    var coordinator: FavoriteCoordinator?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let photoView = UIView()
    
    
    private var reuseID: String {
        return String(describing: FavoritePostTableViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FavoritesPostStorage.posts = CoreDataManager.manager.fetchData(for: FavoritePost.self)
        
        setupLayout()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritePostTableViewCell.self, forCellReuseIdentifier: reuseID)
        
    }
        
    private func setupLayout() {
        view.addSubview(tableView)
        let constratints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constratints)

    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if FavoritesPostStorage.posts.isEmpty {
            return .zero
        } else {
            return FavoritesPostStorage.posts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: FavoritePostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! FavoritePostTableViewCell
        
        let post: FavoritePost = FavoritesPostStorage.posts[indexPath.row]
        cell.configure(with: FavoritePostTableViewCellViewModel(with: post))
        cell.delegate = self
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}

extension FavoriteViewController: FavoritePostTableViewCellDelegate {
    func showDataNotFoundAlert(with title: String, with message: String) {
        coordinator?.showAlert(with: title, with: message)
    }
    
    func showNetworkConnectionProblemAlert(with title: String, with message: String) {
        coordinator?.showAlert(with: title, with: message)
    }
    
}
