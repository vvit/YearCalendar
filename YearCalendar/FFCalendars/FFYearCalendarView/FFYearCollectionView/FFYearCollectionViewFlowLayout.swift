import UIKit

class FFYearCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        return CGSize(width: collectionView.frame.size.width, height: 3 * collectionView.frame.size.height)
    }
}
