
import UIKit

class FavoriteViewController: UIViewController {
    
    var coordinator: FavoriteCoordinator?
    private var isFiltered: Bool = false
    private var inputTextField: UITextField?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let photoView = UIView()
    private let context = CoreDataManager.manager.getContext()
    
    private var reuseID: String {
        return String(describing: FavoritePostTableViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
    
    private func refreshTableView() {
        if isFiltered {
            if let authorName = inputTextField?.text {
                FavoritesPostStorage.posts = CoreDataManager.manager.filterData(for: FavoritePost.self, authorName: authorName)
                tableView.reloadData()
            }
        } else {
            FavoritesPostStorage.posts = CoreDataManager.manager.fetchData(for: FavoritePost.self)
            tableView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        
        if #available(iOS 13.0, *) {
            let filterButtonImage = UIImage(systemName: "magnifyingglass")
            let clearPostButtonImage = UIImage(systemName: "xmark.seal.fill")
            let filterButton = UIBarButtonItem(image: filterButtonImage, style: .plain, target: self, action: #selector(addFilter))
            let clearPostButton = UIBarButtonItem(image: clearPostButtonImage, style: .plain, target: self, action: #selector(clearFilter))
            navigationItem.rightBarButtonItems = [filterButton, clearPostButton]
        } else {}
        
    }
    
    @objc private func addFilter() {
        
        let alertController = UIAlertController(title: "Add filter", message: "Enter author", preferredStyle: .alert)
        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Enter author"
            if let self = self {
                self.inputTextField = textField
            }
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            if let self = self {
                if let authorName = self.inputTextField?.text {
                    FavoritesPostStorage.posts = CoreDataManager.manager.filterData(for: FavoritePost.self, authorName: authorName)
                }
                self.tableView.reloadData()
                self.isFiltered = true
            }
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
    }
    
    @objc private func clearFilter() {
        isFiltered = false
        refreshTableView()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Удалить") { (contextualAction, view, boolValue) in
            let item = FavoritesPostStorage.posts[indexPath.row]
            CoreDataManager.manager.delete(object: item)
            FavoritesPostStorage.posts.remove(at: indexPath.row)
                    tableView.performBatchUpdates {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
        }
        
        return UISwipeActionsConfiguration(actions: [contextItem])
    }
    
      
    
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
