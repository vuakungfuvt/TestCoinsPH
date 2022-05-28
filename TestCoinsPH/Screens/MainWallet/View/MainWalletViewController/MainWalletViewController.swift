//
//  MainWalletViewController.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit

class MainWalletViewController: UIViewController, XibViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let refreshControl = UIRefreshControl()
    private let viewModel: MainWalletViewModel = MainWalletViewModel(userDefaults: UserDefaults.standard, dataAdapter: CoinsPHAPI())

    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        setupView()
        bindViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - init and setup

extension MainWalletViewController: TestCoinsViewViewModel {
    
    func loadData() {
        showLoading()
        
        viewModel.loadAllData { [weak self] in
            guard let self = self else {
                return
            }
            self.hideLoading()
            self.refreshControl.endRefreshing()
            
        } failure: { error in
            self.hideLoading()
            self.refreshControl.endRefreshing()
            self.showError(errorContent: error?.localizedDescription ?? "")
        }
    }
    
    func initData() {
        loadData()
    }
    
    @objc func refresh() {
        loadData()
    }
    
    func setupView() {
        
        self.navigationController?.isNavigationBarHidden = true
        tableView.registerNibCellFor(type: ItemMyWalletTableViewCell.self)
        tableView.registerNibCellFor(type: ItemTransactionTableViewCell.self)
        tableView.set(delegateAndDataSource: self)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.init(named: "mainColor")
        tableView.refreshControl = refreshControl
    }
    
    func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension MainWalletViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sectionTypes[section] {
        case .history:
            return viewModel.itemTransactionViewModels.count
        case .myWallet:
            return viewModel.itemTransactionViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sectionTypes[indexPath.section] {
        case .history:
            guard let itemHistoryCell = tableView.reusableCell(type: ItemTransactionTableViewCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            let itemViewModel = viewModel.itemTransactionViewModels[indexPath.row]
            itemHistoryCell.bindData(viewModel: itemViewModel)
            return itemHistoryCell
        case .myWallet:
            guard let itemMyWalletCell = tableView.reusableCell(type: ItemMyWalletTableViewCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            let itemViewModel = viewModel.itemMyWalletViewModels[indexPath.row]
            itemMyWalletCell.bindData(viewModel: itemViewModel)
            return itemMyWalletCell
        }
    }
}

extension MainWalletViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = viewModel.sectionTypes[indexPath.section]
        guard sectionType == .history else {
            return
        }
        let transaction = viewModel.getTransaction(indexPath: indexPath)
        WalletDetailViewController.push(from: self, animated: true) { vc in
            vc.setViewModel(viewModel: WalletDetailViewModel(transaction: transaction))
        } completion: {
            
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ItemMainWalletHeaderView.initView()
        headerView.setData(title: viewModel.sectionTypes[section].titleSection)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ItemMainWalletHeaderView.heightView
    }
}
