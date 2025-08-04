import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var characters = [CharacterModel]()
    var filteredCharacters = [CharacterModel]()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск по имени"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
        }()
    
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "1"), for: .normal)
        
        return button
    }()
     
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCharacters()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        setupConstraints()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
            guard let text = textField.text else { return }
            
            if text.isEmpty {
                filteredCharacters = characters
            } else {
                filteredCharacters = characters.filter { $0.fullName.contains(text) }
            }
            
            tableView.reloadData()
        }
    
    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.width.equalTo(300)
            
        }
        
        searchButton.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.trailing).offset(16)
            make.centerY.equalTo(searchTextField)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func getCharacters() {
        NetworkManager.shared.getCurrencies { characters in
            DispatchQueue.main.async {
                self.characters = characters
                self.filteredCharacters = characters
                self.tableView.reloadData()
                print("Загрузили \(characters.count) персонажей")

            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else { return
            UITableViewCell() }
        cell.setUp(task: filteredCharacters[indexPath.row])
        cell.delegate = self
        return cell
    }
}
