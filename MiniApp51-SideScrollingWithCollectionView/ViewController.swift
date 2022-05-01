//
//  ViewController.swift
//  MiniApp51-SideScrollingWithCollectionView
//
//  Created by 前田航汰 on 2022/04/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var horizontalCollectionView: UICollectionView!
    // スクロール開始した位置
    var scrollBeginingPoint: CGPoint!
    // スクロールした方向
    var scrollDirection: Bool = true
    var numberMin = 1
    var numberMax = 15
    var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    var cellOffset: CGFloat!

    var photoArray = ["ny","italy","australia","france"]
    var titleArray = ["ニューヨーク","イタリア","オーストラリア","フランス"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        cellWidth = UIScreen.main.bounds.width - 60
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        horizontalCollectionView.showsHorizontalScrollIndicator = false //下のインジケータを削除
        horizontalCollectionView.decelerationRate = .fast // 動作もっさりなので早く見せる
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self

        let nib = UINib(nibName: "CollectionViewCell", bundle: .main)
        horizontalCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let testLayout = PagingPerCellFlowLayout()
        testLayout.headerReferenceSize = CGSize(width: 20, height: horizontalCollectionView.frame.height)
        testLayout.footerReferenceSize = CGSize(width: 20, height: horizontalCollectionView.frame.height)
        testLayout.scrollDirection = .horizontal
        testLayout.minimumLineSpacing = 16
        testLayout.itemSize = CGSize(width: cellWidth, height: horizontalCollectionView.frame.height)
        horizontalCollectionView.collectionViewLayout = testLayout
    }

    // 10番目のCellからスタートする
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        horizontalCollectionView.scrollToItem(at: IndexPath(row: 8, section: 0), at: .centeredHorizontally, animated: false)
    }

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 8, height: 8)
        cell.layer.masksToBounds = false

        cell.label1.text = "\(numbers[indexPath.row])枚目"
        cell.label2.text = "\(numbers.count)のうち\(indexPath.row)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellWidth = viewWidth-175
        cellHeight = viewHeight-500
        cellOffset = viewWidth-cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 ,left: cellOffset/2,bottom: 0,right: cellOffset/2)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in

            if indexPath.row == self.numbers.count - 5 {
                self.numbers.append(self.numberMax + 1)
                self.numbers.append(self.numberMax + 2)
                self.numbers.append(self.numberMax + 3)
                self.numbers.append(self.numberMax + 4)
                self.numbers.append(self.numberMax + 5)
                self.numbers.append(self.numberMax + 6)
                self.numbers.append(self.numberMax + 7)
                self.numbers.append(self.numberMax + 8)
                self.numbers.append(self.numberMax + 9)
                self.numbers.append(self.numberMax + 10)
                self.numberMax += 10
                print("プラス方向に追加\(self.numbers)")
                self.horizontalCollectionView.reloadData()
            }

            if indexPath.row == 5 {
                self.numberMin -= 10
                self.numbers.insert(self.numberMin + 9, at: 0)
                self.numbers.insert(self.numberMin + 8, at: 0)
                self.numbers.insert(self.numberMin + 7, at: 0)
                self.numbers.insert(self.numberMin + 6, at: 0)
                self.numbers.insert(self.numberMin + 5, at: 0)
                self.numbers.insert(self.numberMin + 4, at: 0)
                self.numbers.insert(self.numberMin + 3, at: 0)
                self.numbers.insert(self.numberMin + 2, at: 0)
                self.numbers.insert(self.numberMin + 1, at: 0)
                self.numbers.insert(self.numberMin + 0, at: 0)
                print("マイナス方向に追加\(self.numbers)")
                self.horizontalCollectionView.reloadData()

                self.horizontalCollectionView.contentOffset = CGPoint(x: self.horizontalCollectionView.contentOffset.x +  6*UIScreen.main.bounds.size.width+40, y: 0)
                self.horizontalCollectionView.scrollToItem(at:  IndexPath(row: 16, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
                print(indexPath)

                //self.horizontalCollectionView.scrollToItem(at:  IndexPath(row: 16, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
                //self.scrollToItem(at:IndexPath(row: self.pageCount, section: 0) , at: .centeredHorizontally, animated: false)
                /*
                格闘したコード。ここでエラー起きたら、下記参考に書き直すのもありかも
                self.horizontalCollectionView.contentOffset = CGPoint(x: self.horizontalCollectionView.contentOffset.x + 2*oldContentOffset.x + 900 + 50, y: 0)
                self.horizontalCollectionView.contentOffset = CGPoint(x: self.horizontalCollectionView.contentOffset.x +  10*UIScreen.main.bounds.size.width, y: 0)
                 */
            }


            }
        }
}

/// カルーセルスワイプ時にcellが真ん中に来るように
class PagingPerCellFlowLayout: UICollectionViewFlowLayout {

   var cellWidth: CGFloat = UIScreen.main.bounds.width - 60
   let windowWidth: CGFloat = UIScreen.main.bounds.width

   override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
       if let collectionViewBounds = self.collectionView?.bounds {
           let halfWidthOfVC = collectionViewBounds.size.width * 0.5
           let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
           if let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds) {
               var candidateAttribute: UICollectionViewLayoutAttributes?
               for attributes in attributesForVisibleCells {
                   let candAttr: UICollectionViewLayoutAttributes? = candidateAttribute
                   if candAttr != nil {
                       let a = attributes.center.x - proposedContentOffsetCenterX
                       let b = candAttr!.center.x - proposedContentOffsetCenterX
                       if abs(a) < abs(b) {
                           candidateAttribute = attributes
                       }
                   } else {
                       candidateAttribute = attributes
                       continue
                   }
               }
               if candidateAttribute != nil {
                   return CGPoint(x: candidateAttribute!.center.x - halfWidthOfVC, y: proposedContentOffset.y)
               }
           }
       }
       return CGPoint.zero
   }
}
