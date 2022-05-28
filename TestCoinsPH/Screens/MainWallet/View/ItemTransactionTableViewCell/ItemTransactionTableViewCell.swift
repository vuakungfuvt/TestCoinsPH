//
//  ItemTransactionTableViewCell.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit

class ItemTransactionTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    
    // MARK: - Variables

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(viewModel: ItemTransactionCellViewModel) {
        lblContent.text = viewModel.contentTransaction
        lblQuantity.text = viewModel.quantityTransaction
    }
    
}
