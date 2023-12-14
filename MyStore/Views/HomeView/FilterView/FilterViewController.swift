//
//  FilterViewController.swift
//  MyStore
//
//  Created by Long Tran on 21/06/2023.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backView: UIView!
//   data test
    var lstSection : [Section] = [Section(title: "Các ngành hàng", pills: [PillItem(tille: "laptop cơ bản"), PillItem(tille: "macbook"), PillItem(tille: "laptop dell"), PillItem(tille: "laptop asus")]), Section(title: "Bộ nhớ hệ thông", pills: [PillItem(tille: "8g"), PillItem(tille: "16G")]),
    Section(title: "Hệ điều hành", pills: [PillItem(tille: "window"), PillItem(tille: "macos")])]
    
//    var dataSource : UICollectionViewDiffableDataSource<Section, PillItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
//        configure collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? PillLayout{
            layout.delegate = self
        }
        collectionView.register(HeaderCollectionReusableView.nib(), forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.register(FilterCollectionViewCell.nib(), forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        
//        action dismiss view
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeDismissFilterVc))
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        leftSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
        backView.addGestureRecognizer(tapDismiss)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FilterViewController", bundle: nil)
        self.modalPresentationStyle = .custom
    }
    
    @objc func tapDismiss(){
        self.backView.backgroundColor = .clear
        dismiss(animated: true)
    }

    @objc func leftSwipeDismissFilterVc(_ sender : UISwipeGestureRecognizer){
        if sender.direction == .right {
            self.backView.backgroundColor = .clear
            dismiss(animated: true)
        }
    }
    
//    configure view
    func configure(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = UIColor.black
        self.backView.alpha = 0.1
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func show(sender : UIViewController){
            sender.present(self, animated:  true)
            self.backView.layer.shadowColor = .none
    }
 
}

extension FilterViewController: HeaderCollectionReusableViewDelegate{
    func expand(at indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        lstSection[indexPath.section].isExpand = !lstSection[indexPath.section].isExpand
        UIView.performWithoutAnimation {
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        }
    }
    }

extension FilterViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if lstSection[section].isExpand {
            return lstSection[section].pills.count
        }else{
            return 0
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return lstSection.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
        cell.setup(text: lstSection[indexPath.section].pills[indexPath.row].tille)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
            headerView.setup(text: lstSection[indexPath.section].title)
            headerView.selectedIndexPath = indexPath
            headerView.delegate = self
            return headerView
        }
        else{
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension FilterViewController : PillLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeForPillAtIndexPath indexPath: IndexPath) -> CGSize {
        let text =  lstSection[indexPath.section].pills[indexPath.item].tille
        let font = UIFont(name: "Avenir Heavy", size: 12)!
        let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font : font])
        return CGSize(width: size.width + 13, height: size.height + 15)
    
    }

    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, insestsForItemInSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5 )
    }

    func collectionView(_ collectionView: UICollectionView, itemSpacingInSection section: Int) -> CGFloat {
        return 10
    }


}

