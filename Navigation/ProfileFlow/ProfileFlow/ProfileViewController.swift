
import UIKit

class ProfileViewController: UIViewController {
    
    var coordinator: ProfileCoordinator?
    private var favoritePost: Post?
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerView = ProfileHeaderView()
    private let tableHeaderViewModel: ProfileTableHeaderViewModel
    private let photoView = UIView()
    
    
    private var cancelAnimationButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.backgroundColor = UIColor.white.withAlphaComponent(0)
        button.setTitleColor(UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white), for: .normal)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = true
        button.addTarget(self, action: #selector(cancelAnimationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var reuseID: String {
        return String(describing: PostTableViewCell.self)
    }
    
    private var photosReuseID: String {
        return String(describing: PhotosTableViewCell.self)
    }
    
    init(tableHeaderViewModel: ProfileTableHeaderViewModel)  {
        self.tableHeaderViewModel = tableHeaderViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
        createTimer()
        avatarAnimate()
        logOutButtonOnTapSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.didFinishProfile()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reuseID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: photosReuseID)
        
    }
    
    private func logOutButtonOnTapSetup() {
        headerView.onlogOutButtonTap = { [weak self] in
            self?.coordinator?.logOut()
        }
    }
    
    func createTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCell), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc func updateCell() {
        guard let visibleRows = tableView.indexPathsForVisibleRows else { return }
        
        for indexPath in visibleRows {
            if let cell = tableView.cellForRow(at: indexPath) as? PhotosTableViewCell {
                cell.updateReloadingInfo()
            }
        }
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
    
    @objc private func cellTapped() {
        guard let post = favoritePost else { return }
        getCoreData(post)
        coordinator?.showAlert(with: AlertLocalization.profileAlertTitle.localizedValue, with: "")

    }
    
    private func getCoreData(_ post: Post) {
        let context = CoreDataManager.manager.getBackgroundContext()
        let favoritePost = CoreDataManager.manager.createObject(from: FavoritePost.self, context: context)
        favoritePost.author = post.author
        favoritePost.descript = post.description
        favoritePost.image = post.image?.pngData()
        favoritePost.likes = Int64(post.likes)
        favoritePost.views = Int64(post.view)
        
        CoreDataManager.manager.save(context: context)
    }
    
    private func avatarAnimate() {
        let tapAvatarGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        headerView.avatarImageView.isUserInteractionEnabled = true
        headerView.avatarImageView.addGestureRecognizer(tapAvatarGestureRecognizer)
    }

    @objc private func avatarTapped() {
        self.view.addSubview(self.photoView)
    
        UIView.animate(withDuration: 0.5, animations: {
            
            self.photoView.frame = UIScreen.main.bounds
            self.photoView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            
            self.photoView.addSubview(self.headerView.avatarImageView)
            self.headerView.avatarImageView.translatesAutoresizingMaskIntoConstraints = true
            
            self.headerView.avatarImageView.frame.origin.x = (self.photoView.frame.width - self.headerView.avatarImageView.frame.width) / 2
            self.headerView.avatarImageView.frame.origin.y = (self.photoView.frame.height - self.view.safeAreaInsets.top - self.headerView.avatarImageView.frame.height) / 2
            
            self.headerView.avatarImageView.layer.cornerRadius = 0
            self.headerView.avatarImageView.layer.borderWidth = 0
            
            self.headerView.avatarImageView.transform = CGAffineTransform(scaleX: self.photoView.frame.width / self.headerView.avatarImageView.frame.width,
            y: self.photoView.frame.width / self.headerView.avatarImageView.frame.width)
        }, completion: { finished in
            if finished {
                self.photoView.addSubview(self.cancelAnimationButton)
                self.cancelAnimationButton.frame = .init(x: self.photoView.frame.maxX - 40, y: 40, width: 40, height: 40)
                UIView.animate(withDuration: 0.3, animations: {
                    self.cancelAnimationButton.alpha = 1

                })
            }
        })
    }
    
    @objc private func cancelAnimationButtonTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.cancelAnimationButton.alpha = 0
            
        }, completion: { finished in
            if finished {
                UIView.animate(withDuration: 0.5, animations: {
                    self.headerView.avatarImageView.transform = .identity
                    self.headerView.avatarImageView.layer.cornerRadius = self.headerView.avatarImageSize.height / 2
                    self.headerView.avatarImageView.layer.borderWidth = 3
                    
                    self.headerView.addSubview(self.headerView.avatarImageView)
                    self.headerView.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
                    
                    self.headerView.avatarImageView.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 16).isActive = true
                    self.headerView.avatarImageView.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 16).isActive = true
                    
                    self.photoView.removeFromSuperview()
                })
            }
        })
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PostStorage.posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostStorage.posts[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let photosCell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: photosReuseID, for: indexPath) as! PhotosTableViewCell
            photosCell.configure(with: PhotosTableViewCellViewModel())
            return photosCell
        } else {
            let postCell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PostTableViewCell
            
            let post: Post = PostStorage.posts[indexPath.section][indexPath.row]
            postCell.configure(with: PostTableViewCellViewModel(with: post))
            postCell.delegate = self
            return postCell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            coordinator?.pushPhotosVC()
        } else {
            let post = PostStorage.posts[1][indexPath.row]
            favoritePost = post
            let tapCellGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            tapCellGestureRecognizer.numberOfTapsRequired = 2
            tableView.addGestureRecognizer(tapCellGestureRecognizer)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        headerView.configure(with: tableHeaderViewModel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: .zero)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        return 8
    }
}

extension ProfileViewController: PostTableViewCellDelegate {
    func showDataNotFoundAlert(with title: String, with message: String) {
        coordinator?.showAlert(with: title, with: message)
    }
    
    func showNetworkConnectionProblemAlert(with title: String, with message: String) {
        coordinator?.showAlert(with: title, with: message)
    }
    
}

// MARK: - UITableViewDragDelegate

extension ProfileViewController: UITableViewDragDelegate {
    func tableView(
        _ tableView: UITableView,
        itemsForBeginning session: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        if let image =  PostStorage.posts[1][indexPath.item].image {
            let descr = PostStorage.posts[1][indexPath.item].description
            let dragImageItem = UIDragItem(itemProvider: NSItemProvider(object: image))
            let dragDescrItem = UIDragItem(itemProvider: NSItemProvider(object: NSString(string: descr)))
            return [dragDescrItem, dragImageItem]
        } else {
            return []
        }
    }
}

// MARK: - UITableViewDropDelegate

extension ProfileViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self) ||
        session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func tableView(
        _ tableView: UITableView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?
    ) -> UITableViewDropProposal {
        let dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        return dropProposal
    }
    
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
            
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        var indexPaths = [IndexPath]()
        
        /// Основной метод дропа dragItem
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            let stringItems = items as! [String]
            for (_, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row, section: destinationIndexPath.section)
                let post = Post(
                    author: "Drag&Drop",
                    description: item,
                    image: UIImage(),
                    likes: 0,
                    view: 0
                )
                PostStorage.posts[1].insert(post, at: indexPath.row)
                indexPaths.append(indexPath)
            }
            
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
}
