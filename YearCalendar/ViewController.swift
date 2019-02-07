import UIKit

class ViewController: UIViewController {
    private var boolDidLoad = false
    private var viewCalendarYear: FFYearCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addCalendars()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !boolDidLoad {
            boolDidLoad = true
            buttonTodayAction()
        }
    }

    private func addCalendars() {
        let frame = CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 50)
        viewCalendarYear = FFYearCalendarView(frame: frame)
        view.addSubview(viewCalendarYear)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        viewCalendarYear.invalidateLayout()
    }

    private func buttonTodayAction() {
        let date = Date()

        if let today = Date.dateWithYear(year: date.components().year ?? 0,
                                         month: date.components().month ?? 0,
                                         day: date.components().day ?? 1) {
            FFDateManager.sharedManager.dateCalendar = today
        }
    }
}
