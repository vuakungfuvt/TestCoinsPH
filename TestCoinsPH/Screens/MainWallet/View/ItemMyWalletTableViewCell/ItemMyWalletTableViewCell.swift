//
//  ItemMyWalletTableViewCell.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit
import Nuke

class ItemMyWalletTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imvCoin: UIImageView!
    @IBOutlet weak var lblCoinName: UILabel!
    @IBOutlet weak var lblCoinPrice: UILabel!
    
    // MARK: - Variables

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(viewModel: ItemMyWalletCellViewModel) {
        lblCoinName.text = viewModel.coinName
        lblCoinPrice.text = viewModel.coinPrice
        if let url = URL(string: viewModel.imageUrl) {
            Nuke.loadImage(with: url, options: ImageLoadingOptions.shared, into: imvCoin) { result in
                
            }
        }
    }
}
