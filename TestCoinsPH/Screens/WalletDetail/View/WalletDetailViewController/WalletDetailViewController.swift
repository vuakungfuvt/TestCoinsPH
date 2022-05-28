//
//  WalletDetailViewController.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit

class WalletDetailViewController: UIViewController, XibViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnBackNav: UIButton!
    @IBOutlet weak var lblOtherPeople: UILabel!
    @IBOutlet weak var lblContentTransaction: UILabel!
    @IBOutlet weak var lblOtherPeopleContent: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    // MARK: - Variables
    private var viewModel: WalletDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        setupView()
        bindViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setViewModel(viewModel: WalletDetailViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Actions
    
    @IBAction func btnBackTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackNavTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - init and setupp

extension WalletDetailViewController: TestCoinsViewViewModel {
    func initData() {
        lblContentTransaction.text = viewModel.getContentTransaction()
        lblOtherPeople.text = viewModel.getOtherRole()
        lblOtherPeopleContent.text = viewModel.getOtherRoleContent()
        lblAmount.text = viewModel.getAmount()
    }
    
    func setupView() {
        
    }
    
    func bindViewModel() {
        
    }
    
    
}
