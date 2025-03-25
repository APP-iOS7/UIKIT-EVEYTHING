//
//  TomJRNLViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import UIKit

class TomJournalViewController: UIViewController {

    private lazy var NavPlusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JournalCell.self, forCellReuseIdentifier: "JournalCell")
        tableView.rowHeight = 65
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNav()
        setupSearchBar()
    }
}


private extension TomJournalViewController {
    
    func setupNav() {
        self.navigationItem.title = "Journal"
        self.navigationItem.rightBarButtonItem = NavPlusButton
    }
    
    func setupSearchBar() {
        // TODO: Setup Search
    }
    
}

// MARK: - Configure Methods
private extension TomJournalViewController {
    @objc func showModal() {
        let vc = JournalModal()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

// MARK: - Delegate, DataSource
extension TomJournalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10 // TODO: Coll 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalCell
        cell.title = "a"
        cell.subtitle = "alsjlkne"
        cell.image = UIImage(systemName: "square.and.arrow.down.badge.checkmark")
        
        return cell
    }
    
    
}

// MARK: - Set up UI
private extension TomJournalViewController {
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

// TODO: TableViewDifferable 사용해서 바꿔보기.
