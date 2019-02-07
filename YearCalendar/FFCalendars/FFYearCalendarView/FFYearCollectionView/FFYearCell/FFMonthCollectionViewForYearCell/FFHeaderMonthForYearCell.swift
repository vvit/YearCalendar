import UIKit

class FFHeaderMonthForYearCell: UICollectionReusableView {
    var date: Date!
    var labelTitle: UILabel!

    func addWeekLabels(withSizeOfCells sizeOfCells: CGSize) {
        if labelTitle == nil {
            let height = frame.size.height / 4

            labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 3 * height))
            labelTitle.textColor = .black
            labelTitle.textAlignment = .center
            labelTitle.font = UIFont.boldSystemFont(ofSize: 15)
            addSubview(labelTitle)
        }

        labelTitle.text = k_arrayMonthNameAbrev[(date.components().month ?? 1) - 1]
    }
}
