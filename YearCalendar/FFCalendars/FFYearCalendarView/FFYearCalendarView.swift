import UIKit

class FFYearCalendarView: UIView {
    private var collectionViewYear: FFYearCollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        NotificationCenter.default.addObserver(self, selector: #selector(dateChanged), name: NSNotification.Name(rawValue: k_DATE_MANAGER_DATE_CHANGED), object: nil)
        backgroundColor = UIColor.white

        collectionViewYear = FFYearCollectionView(frame: CGRect(x: k_SPACE_COLLECTIONVIEW_CELL_YEAR,
                                                                y: k_SPACE_COLLECTIONVIEW_CELL_YEAR,
                                                                width: frame.size.width-2*k_SPACE_COLLECTIONVIEW_CELL_YEAR,
                                                                height: frame.size.height-2*k_SPACE_COLLECTIONVIEW_CELL_YEAR),
                                                  collectionViewLayout: FFYearCollectionViewFlowLayout())
//        [collectionViewYear setProtocol:self];
        addSubview(collectionViewYear)

        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewYear.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func invalidateLayout() {
        collectionViewYear.collectionViewLayout.invalidateLayout()
    }

    @objc func dateChanged(not: NSNotification) {
        collectionViewYear.setContentOffset(CGPoint(x: 0, y: collectionViewYear.frame.size.height), animated: false)
        collectionViewYear.reloadData()
    }
}
