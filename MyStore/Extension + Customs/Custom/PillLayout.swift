//
//  PillLayout.swift
//  MyStore
//
//  Created by Long Tran on 28/06/2023.
//

import UIKit

protocol PillLayoutDelegate : AnyObject{
    func collectionView(_ collectionView : UICollectionView, sizeForPillAtIndexPath indexPath : IndexPath) -> CGSize
    func collectionView(_ collectionView : UICollectionView, heightForHeaderInSection section : Int) -> CGFloat
    func collectionView(_ collectionView : UICollectionView, insestsForItemInSection section : Int) -> UIEdgeInsets
    func collectionView(_ collectionView : UICollectionView, itemSpacingInSection section: Int) -> CGFloat
}

class PillLayout: UICollectionViewLayout {
    
    var layoutHeight : CGFloat = 0.0
    weak var delegate : PillLayoutDelegate?
    private var headerCache : [UICollectionViewLayoutAttributes] = []
    private var itemCache  : [UICollectionViewLayoutAttributes] = []
    private var isFirstLayout: Bool   = false
    
    override func prepare() {
        super.prepare()
        itemCache.removeAll()
        headerCache.removeAll()
        guard let collectionView = collectionView, itemCache.isEmpty, headerCache.isEmpty  else {
            return
        }
        var layouWidthIterator : CGFloat = 0
        layoutHeight = 0
        for section in 0..<collectionView.numberOfSections{
            let inset: UIEdgeInsets = delegate?.collectionView(collectionView   , insestsForItemInSection: section) ?? UIEdgeInsets.zero
            let interItemSpacing : CGFloat = delegate?.collectionView(collectionView, itemSpacingInSection: section) ?? 0.0
            let headerSize = delegate?.collectionView(collectionView, heightForHeaderInSection: section) ?? 0.0
            var itemSize : CGSize = .zero
            let attrHeader = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(row: 0, section: section))
            attrHeader.frame = CGRect(x: 0.0, y: layoutHeight, width: collectionView.frame.size.width, height: headerSize)
            layoutHeight += headerSize + inset.top
            headerCache.append(attrHeader)
            for item  in 0..<collectionView.numberOfItems(inSection: section){
                let indexPath = IndexPath(item: item, section: section)
                itemSize = delegate?.collectionView(collectionView, sizeForPillAtIndexPath: indexPath) ?? .zero
                if (layouWidthIterator + itemSize.width + inset.left + inset.right) > collectionView.frame.width{
                    layouWidthIterator = 0
                    layoutHeight += itemSize.height + interItemSpacing
                }
                let frame = CGRect(x: layouWidthIterator + inset.left, y: layoutHeight, width: itemSize.width, height: itemSize.height)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                itemCache.append(attributes)
                layouWidthIterator = layouWidthIterator + frame.width + interItemSpacing
            }
            layoutHeight += itemSize.height  + inset.bottom
            layouWidthIterator = 0.0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        var visbleLayoutAttributes : [UICollectionViewLayoutAttributes] = []
        for attribute in itemCache {
            if attribute.frame.intersects(rect){
                visbleLayoutAttributes.append(attribute)

            }
        }
        for attribute in headerCache{
            if attribute.frame.intersects(rect){
                visbleLayoutAttributes.append(attribute)
            }
        }
        return visbleLayoutAttributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        return headerCache[indexPath.section]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)
        return itemCache[indexPath.item]
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: layoutHeight)
    }
    
    private var contentWidth : CGFloat{
        guard let collectionView = collectionView else{
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        layoutHeight = 0
        return true
    }
    
    
    
}
