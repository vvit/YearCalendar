import UIKit

class FFMonthCollectionViewForYearCell: UICollectionView {
    private var sizeOfCells = CGSize.zero
    private var arrayDates = [Date?]()
    private var dateFirstDayOfMonth: Date?

    var date: Date!

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())

        isUserInteractionEnabled = true
        dataSource = self
        delegate = self
        backgroundColor = .white

        register(FFMonthCellForYearCell.self, forCellWithReuseIdentifier: k_REUSE_IDENTIFIER_MONTH_CELL)
        register(FFHeaderMonthForYearCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: k_REUSE_IDENTIFIER_MONTH_HEADER)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension FFMonthCollectionViewForYearCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


        let compDateManager = date.components()
        dateFirstDayOfMonth = Date.dateWithYear(year: compDateManager.year ?? 0, month: compDateManager.month ?? 0, day: 1)
        let componentsFirstDayOfMonth = dateFirstDayOfMonth?.components()

        let lastDayMonth = dateFirstDayOfMonth?.numberOfDaysInMonthCount
        let numOfCellsInCollection = (dateFirstDayOfMonth?.numberOfWeekInMonthCount ?? 0) * 7
        var i = 1 - ((componentsFirstDayOfMonth?.weekday ?? 0) - 1)
        let j = numOfCellsInCollection - ((componentsFirstDayOfMonth?.weekday ?? 0) - 1)

        arrayDates.removeAll()

        while i <= j {
            let exists = (i >= 1 && i <= (lastDayMonth ?? 0))
            arrayDates.append(exists ?
                Date.dateWithYear(year: compDateManager.year ?? 0, month: compDateManager.month ?? 0, day: i) :
                nil)
            i += 1
        }

        sizeOfCells = CGSize(width: (frame.size.width) / 7, height: (frame.size.height - 40.0) / 6)

        return arrayDates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: k_REUSE_IDENTIFIER_MONTH_CELL, for: indexPath) as! FFMonthCellForYearCell
        cell.initLayout()

        if let dateObj = arrayDates[indexPath.row] {
            let components = dateObj.components()
            cell.labelDay.text = (components.day != nil) ? "\(components.day!)" : "?"

            if Date.isTheSameDateTheCompA(compA: components, andCompB: Date().components()) {
                cell.markAsCurrentDay()
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview: UICollectionReusableView? = nil

        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: k_REUSE_IDENTIFIER_MONTH_HEADER, for: indexPath) as? FFHeaderMonthForYearCell
            headerView?.date = date
            headerView?.addWeekLabels(withSizeOfCells: sizeOfCells)
            reusableview = headerView
        }

        return reusableview!
    }
}

// MARK: - UICollectionViewDelegate
extension FFMonthCollectionViewForYearCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let obj = arrayDates[indexPath.row]
//
//        if obj != NSNull() && `protocol` != nil && `protocol`.responds(to: #selector(FFMonthCollectionViewForYearCell.showMonthCalendar)) {
//            FFDateManager.shared().setCurrentDate(obj as? Date)
//            `protocol`.showMonthCalendar()
//        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FFMonthCollectionViewForYearCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeOfCells
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerViewSize = CGSize(width: frame.size.width, height: 32.0)
        return headerViewSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
