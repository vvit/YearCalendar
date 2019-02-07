import UIKit

class FFYearCell: UICollectionViewCell {
    var date: Date! {
        didSet {
            collectionView.date = date
            collectionView.reloadData()
        }
    }

    private var collectionView: FFMonthCollectionViewForYearCell!

    func initLayout() {
        if collectionView == nil {
            collectionView = FFMonthCollectionViewForYearCell(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height),
                                                              collectionViewLayout: UICollectionViewLayout())
//            collectionView.protocol = self
            addSubview(collectionView)
        }
    }

    // MARK: - FFMonthCollectionViewForYearCell Protocol
//    @objc func showMonthCalendar() {
//
//        if `protocol` != nil && `protocol`.responds(to: #selector(self.showMonthCalendar)) {
//            `protocol`.showMonthCalendar()
//        }
//    }
}
