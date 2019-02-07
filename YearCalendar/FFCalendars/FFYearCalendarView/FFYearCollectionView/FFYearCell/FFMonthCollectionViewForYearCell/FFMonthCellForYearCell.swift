import UIKit

class FFMonthCellForYearCell: UICollectionViewCell {
    var labelDay: UILabel!

    func initLayout() {
        if labelDay == nil {
            labelDay = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
            labelDay.textAlignment = .center
            labelDay.font = UIFont.systemFont(ofSize: 8)
            addSubview(labelDay)
        }

        labelDay.text = ""
        labelDay.textColor = UIColor.black
    }

    func markAsCurrentDay() {
        labelDay.textColor = UIColor.red
    }
}
