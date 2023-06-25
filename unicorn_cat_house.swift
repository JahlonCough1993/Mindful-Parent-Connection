//AppDelegate.swift

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let parentSupportGroupVC = ParentSupportGroupViewController()
        let navigationController = UINavigationController(rootViewController: parentSupportGroupVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

//ParentSupportGroupViewController.swift

import UIKit

class ParentSupportGroupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Parent Support Group"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start New Group", style: .plain, target: self, action: #selector(createNewGroup))
    }
    
    @objc func createNewGroup() {
        let createGroupVC = CreateGroupViewController()
        navigationController?.pushViewController(createGroupVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupportGroupCell", for: indexPath) as! SupportGroupTableViewCell
        let group = supportGroups[indexPath.row]
        cell.configure(with: group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            supportGroups.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let group = supportGroups[indexPath.row]
        let detailGroupVC = DetailGroupViewController()
        detailGroupVC.group = group
        navigationController?.pushViewController(detailGroupVC, animated: true)
    }
    
    func setUpUI() {
        view.addSubview(tableView)
        tableView.register(SupportGroupTableViewCell.self, forCellReuseIdentifier: "SupportGroupCell")
        tableView.addConstraintsToFillView(view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private var supportGroups = [SupportGroup]()
}

//SupportGroupTableViewCell.swift

import UIKit

class SupportGroupTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        nameLabel.addConstraintsToFill(contentView.layoutMarginsGuide, top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with supportGroup: SupportGroup) {
        nameLabel.text = supportGroup.name
        locationLabel.text = supportGroup.location
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    
}

//CreateGroupViewController.swift

import UIKit

class CreateGroupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Group"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveGroup))
    }
    
    @objc func saveGroup() {
        guard let groupName = groupNameTextField.text, groupName.count > 0 else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please enter a group name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let group = SupportGroup(name: groupName)
        parentSupportGroupVC.supportGroups.append(group)
        navigationController?.popViewController(animated: true)
    }
    
    func setUpUI() {
        view.addSubview(groupNameTextField)
        groupNameTextField.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        groupNameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        groupNameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    //MARK: Properties
    private let groupNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Group Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    private let parentSupportGroupVC: ParentSupportGroupViewController
    
    init(parentSupportGroupVC: ParentSupportGroupViewController) {
        self.parentSupportGroupVC = parentSupportGroupVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//DetailGroupViewController.swift

import UIKit

class DetailGroupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = group?.name
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        
        nameLabel.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        locationLabel.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        if group != nil {
            nameLabel.text = group?.name
            locationLabel.text = group?.location
        }
    }
    
    //MARK: Properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .darkGray
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    var group: SupportGroup?
}

//SupportGroup.swift

import Foundation

struct SupportGroup {
    let name: String
    let location: String?
}