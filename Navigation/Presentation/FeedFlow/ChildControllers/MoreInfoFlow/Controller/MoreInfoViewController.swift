//
//  MoreInfoViewController.swift
//  Navigation
//
//  Created by Евгений on 31.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

protocol MoreInfoViewControllerDelegate: AnyObject {
    func moreInfoViewController(_ moreInfoViewController: MoreInfoViewController, hidePost post: Post?)
    func moreInfoViewController(_ moreInfoViewController: MoreInfoViewController, addPost post: Post?)
}

final class MoreInfoViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: MoreInfoViewControllerDelegate?
    
    // MARK: - Private properties
    
    private let moreInfoView = MoreInfoView()
    private let post: Post?
    
    // MARK: - Initializers
    
    init(post: Post?) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = moreInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreferredSize()
        setupTableView()
    }
    
    private func setupPreferredSize() {
        preferredContentSize = CGSize(width: 160, height: 104)
    }
    
    private func setupTableView() {
        moreInfoView.moreInfoTableView.delegate = self
        moreInfoView.moreInfoTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension MoreInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            delegate?.moreInfoViewController(self, hidePost: post)
            dismiss(animated: true, completion: nil)
        case 1:
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.delegate?.moreInfoViewController(self, addPost: self.post)
            }
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension MoreInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MoreInfoTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: MoreInfoTableViewCell.self),
                for: indexPath
        ) as? MoreInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: indexPath.row)
        return cell
    }
}
