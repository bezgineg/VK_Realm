
import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    var coordinator: FavoriteCoordinator?
    private var isFiltered: Bool = false
    private var inputTextField: UITextField?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let photoView = UIView()
    private let context = CoreDataManager.manager.getContext()
    private let fetchResultController = CoreDataManager.manager.fetchResultController
    
    private var reuseID: String {
        return String(describing: FavoritePostTableViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
        setupTableView()
        fetchResultController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
    
    private func refreshTableView() {
        if isFiltered {
            if let authorName = inputTextField?.text {
                CoreDataManager.manager.filterData(authorName: authorName)
                tableView.reloadData()
            }
        } else {
            CoreDataManager.manager.performResultController()
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
        
        let alertController = UIAlertController(title: AlertLocalization.favoriteAlertTitle.localizedValue, message: AlertLocalization.favoriteMessageTitle.localizedValue, preferredStyle: .alert)
        alertController.addTextField { [weak self] textField in
            textField.placeholder = AlertLocalization.favoriteAlertPlaceholder.localizedValue
            if let self = self {
                self.inputTextField = textField
            }
        }


        let saveAction = UIAlertAction(title: AlertLocalization.saveActionTitle.localizedValue, style: .default) { [weak self] _ in

            if let self = self {
                if let authorName = self.inputTextField?.text {
                    CoreDataManager.manager.filterData(authorName: authorName)
                }
                self.tableView.reloadData()
                self.isFiltered = true
            }
        }
            
        let cancelAction = UIAlertAction(title: AlertLocalization.cancelActionTitle.localizedValue, style: .cancel) { _ in }

            
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
        guard let posts = fetchResultController.fetchedObjects else {
            return 0
        }
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let post = fetchResultController.object(at: indexPath)
        let cell: FavoritePostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! FavoritePostTableViewCell
        
        cell.configure(with: post)
        cell.delegate = self
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: FavoriteFlowLocalization.deleteFavoriteItem.localizedValue) { [ weak self ] contextualAction, view, boolValue in
            if let self = self {
                let post = self.fetchResultController.object(at: indexPath)
                CoreDataManager.manager.delete(object: post)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [contextItem])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}

extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.performBatchUpdates {
                tableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
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
