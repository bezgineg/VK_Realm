
import UIKit
import CoreData

final class FavoriteViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var coordinator: FavoriteCoordinator?
    
    // MARK: - Private Properties
    
    private var isFiltered: Bool = false
    private var inputTextField: UITextField?
    private var storageManager: DataStorageProtocol
    private let mainView = FavoriteView()
    
    // MARK: - Initializers
    
    init(storageManager: DataStorageProtocol = CoreDataManager.manager) {
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
        
        setupNavigationBar()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
    
    // MARK: - Private Methods
    
    private func refreshTableView() {
        if isFiltered {
            if let authorName = inputTextField?.text {
                storageManager.filterData(authorName: authorName)
                mainView.tableView.reloadData()
            }
        } else {
            storageManager.performResultController()
            mainView.tableView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor.createColor(
            lightMode: Colors.white,
            darkMode: Colors.black
        )
        
        if #available(iOS 13.0, *) {
            let filterButtonImage = UIImage(systemName: "magnifyingglass")
            let clearPostButtonImage = UIImage(systemName: "xmark.seal.fill")
            let filterButton = UIBarButtonItem(
                image: filterButtonImage,
                style: .plain,
                target: self,
                action: #selector(addFilter)
            )
            let clearPostButton = UIBarButtonItem(
                image: clearPostButtonImage,
                style: .plain,
                target: self,
                action: #selector(clearFilter)
            )
            navigationItem.rightBarButtonItems = [filterButton, clearPostButton]
        }
    }
    
    @objc private func addFilter() {
        let alertController = UIAlertController(
            title: AlertLocalization.favoriteAlertTitle.localizedValue,
            message: AlertLocalization.favoriteMessageTitle.localizedValue,
            preferredStyle: .alert
        )
        alertController.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = AlertLocalization.favoriteAlertPlaceholder.localizedValue
            self.inputTextField = textField
        }

        let saveAction = UIAlertAction(
            title: AlertLocalization.saveActionTitle.localizedValue,
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }
            if let authorName = self.inputTextField?.text {
                self.storageManager.filterData(authorName: authorName)
            }
            self.mainView.tableView.reloadData()
            self.isFiltered = true
        }
            
        let cancelAction = UIAlertAction(
            title: AlertLocalization.cancelActionTitle.localizedValue,
            style: .cancel
        ) { _ in }
            
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func clearFilter() {
        isFiltered = false
        refreshTableView()
    }
    
    private func setDelegates() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        storageManager.fetchResultController.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = storageManager.fetchResultController.fetchedObjects else {
            return 0
        }
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FavoritePostTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: FavoritePostTableViewCell.self),
            for: indexPath
        ) as? FavoritePostTableViewCell else { return UITableViewCell () }
        
        let post = storageManager.fetchResultController.object(at: indexPath)
        cell.configure(with: post)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(
            style: .destructive,
            title: FavoriteFlowLocalization.deleteFavoriteItem.localizedValue
        ) { [ weak self ] _, _, _ in
            guard let self = self else { return }
            let post = self.storageManager.fetchResultController.object(at: indexPath)
            self.storageManager.delete(object: post)
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

// MARK: - NSFetchedResultsControllerDelegate

extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView.tableView.beginUpdates()
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        switch type {
        case .delete:
            mainView.tableView.performBatchUpdates {
                mainView.tableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView.tableView.endUpdates()
    }
}
