
import UIKit

class InfoViewController: UIViewController {
    
    var coordinator: InfoCoordinator?
    
    private var residents = [String]()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.setupLabel()
        return label
    }()
    
    private let planetLabel: UILabel = {
        let label = UILabel()
        label.setupLabel()
        return label
    }()
    
    private let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle("Show alert", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let reuseID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        view.backgroundColor = .systemYellow
        setupLayout()
        configureUserLabel()
        jsonDecodePlanet()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.didFinishInfo()
    }
    
    private func configureUserLabel() {
        let string = "https://jsonplaceholder.typicode.com/todos/1"
        
        guard let url = URL(string: string) else { return }
        
        NetworkManager.getJson(with: url) { data in
            if let data = data,
               let dictionary = try? NetworkManager.toOject(json: data),
               let title = dictionary["title"] as? String
            {
                let user = User(title: title)
                DispatchQueue.main.async {
                    self.userLabel.text = user.title
                }
            }
        }
    }
    
    private func jsonDecodePlanet() {
        let string = "https://swapi.dev/api/planets/1/"
        
        guard let url = URL(string: string) else { return }
        
        let jsonDecoder = JSONDecoder()
        
        NetworkManager.getJson(with: url) { data in
            if let data = data,
               let planet = try? jsonDecoder.decode(Planet.self, from: data) {
                DispatchQueue.main.async {
                    self.planetLabel.text = planet.orbitalPeriod
                }
                self.getResidentsName(residents: planet.residents)
            }
        }
    }
    
    private func getResidentsName(residents: [String]) {
        for urlString in residents {
                                
            guard let url = URL(string: urlString) else { return }
            
            NetworkManager.getJson(with: url) { data in
                if let data = data,
                   let dictionary = try? NetworkManager.toOject(json: data),
                   let name = dictionary["name"] as? String
                {
                    let resident = Resident(name: name)
                    self.residents.append(resident.name)
                }
            }
        }
    }
    
    
    
    @objc private func showAlert() {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.toAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
    }
    
    private func setupLayout() {
        view.addSubview(alertButton)
        view.addSubview(userLabel)
        view.addSubview(planetLabel)
        view.addSubview(tableView)
        
        let constratints = [
            
            userLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            userLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            planetLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 50),
            planetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 50),
            alertButton.widthAnchor.constraint(equalToConstant: 150),
            alertButton.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constratints)
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        
        cell.textLabel?.text = residents[indexPath.row]
                
        return cell
    }
    
    
}
