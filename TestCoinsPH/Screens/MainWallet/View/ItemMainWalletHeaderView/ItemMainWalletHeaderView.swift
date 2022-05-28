//
//  ItemMainWalletHeaderView.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit

class ItemMainWalletHeaderView: BaseNibView {

    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Variables
    static let heightView: CGFloat = 40
    
    class func initView() -> ItemMainWalletHeaderView {
        let customView = ItemMainWalletHeaderView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: heightView))
        return customView
    }
    
    func setData(title: String) {
        lblTitle.text = title
    }
}
