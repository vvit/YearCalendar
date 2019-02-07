import UIKit

class FFYearCollectionView: UICollectionView {
    private var lastContentOffset = CGFloat(0)

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        backgroundColor = .white

        dataSource = self
        delegate = self

        register(FFYearCell.self, forCellWithReuseIdentifier: k_REUSE_IDENTIFIER_MONTH_CELL)

        isScrollEnabled = true
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeYear(_ isUp: Bool) {
        var dateComponents = DateComponents()
        dateComponents.year = isUp ? 1 : -1
        let calendar = Calendar.current as NSCalendar

        var newDate: Date? = nil
        if let current = FFDateManager.sharedManager.dateCalendar {
            newDate = calendar.date(byAdding: dateComponents, to: current as Date, options: [])
        }

        FFDateManager.sharedManager.dateCalendar = newDate
    }
}

// MARK: - UICollectionViewDataSource
extension FFYearCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: k_REUSE_IDENTIFIER_MONTH_CELL, for: indexPath) as! FFYearCell
//        cell?.protocol = self
        cell.initLayout()

        let comp = FFDateManager.sharedManager.dateCalendar.components()
        cell.date = Date.dateWithYear(year: (comp.year ?? 0) + (indexPath.section - 1),
                                      month: indexPath.row + 1,
                                      day: 1)!
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FFYearCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    if (protocol != nil && [protocol respondsToSelector:@selector(showMonthCalendar)]) {
//        [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[[FFDateManager sharedManager] currentDate].componentsOfDate.year month:(indexPath.row+1) day:1]];
//        [protocol showMonthCalendar];
//    }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FFYearCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isLandscape: Bool = UIApplication.shared.statusBarOrientation.isLandscape

        let lines: CGFloat = isLandscape ? 3 : 4
        let columns: CGFloat = isLandscape ? 4 : 3

        return CGSize(width: (frame.size.width - (columns - 1) * k_SPACE_COLLECTIONVIEW_CELL_YEAR) / columns,
                     height: (frame.size.height - (lines - 1) * k_SPACE_COLLECTIONVIEW_CELL_YEAR) / lines)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return k_SPACE_COLLECTIONVIEW_CELL_YEAR
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UIScrollViewDelegate
extension FFYearCollectionView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            changeYear(false)
        } else if lastContentOffset < scrollView.contentOffset.y {
            changeYear(true)
        }
    }
}
