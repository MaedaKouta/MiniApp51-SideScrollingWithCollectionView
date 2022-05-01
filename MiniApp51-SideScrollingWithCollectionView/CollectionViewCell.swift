//
//  CollectionViewCell.swift
//  MiniApp51-SideScrollingWithCollectionView
//
//  Created by 前田航汰 on 2022/04/30.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
    }

}
