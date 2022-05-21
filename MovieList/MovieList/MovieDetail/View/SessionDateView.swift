//
//  SessionDateView.swift
//  MovieList
//
//  Created by Jiawei on 2022/5/14.
//

import Charts
import CSPickerView
import UIKit

class SessionDateView: UIView {
    private var _currentDate = Date.now.appendDay(date_dis: 10)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "SESSION DATE"
        return label
    }()

    private lazy var dateLabel: UILabel = { [weak self] in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = self?._currentDate.getDate()
        label.textColor = themeColor
        return label
    }()

    private lazy var wedLabel: UILabel = { [weak self] in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = self?._currentDate.getWeek()
        return label
    }()

    private lazy var monLabel: UILabel = { [weak self] in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = self?._currentDate.getMonth()
        label.textColor = .lightGray
        return label
    }()

    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .lightGray
        button.tag = 1
        button.addTarget(self, action: #selector(changeDate(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var forwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.tag = 2
        button.addTarget(self, action: #selector(changeDate(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var sessionTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "SESSION TIME"
        return label
    }()

    private lazy var bookSeatBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setTitle("BOOK SEATS", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(book), for: .touchUpInside)
        return button
    }()

    private lazy var barCharView: BarChartView = {
        let chartView = BarChartView()
        let months = ["8:00am", "11:30am", "2:00pm", "5:30pm", "7:00pm"]
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 7)
        chartView.xAxis.axisMinLabels = 5
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chartView.drawGridBackgroundEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.legend.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.drawBordersEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(10)
        }

        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }

        addSubview(wedLabel)
        wedLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel.snp.right).offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }

        addSubview(monLabel)
        monLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel.snp.right).offset(15)
            make.top.equalTo(wedLabel.snp.bottom).offset(5)
        }

        addSubview(forwardButton)
        forwardButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }

        addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            make.right.equalTo(forwardButton.snp.left).offset(-10)
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }

        addSubview(sessionTimeLabel)
        sessionTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
        }

        addSubview(barCharView)
        barCharView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(sessionTimeLabel.snp.bottom).offset(10)
            make.height.equalTo(200)
        }

        setDataCount(4, range: 20)

        addSubview(bookSeatBtn)
        bookSeatBtn.snp.makeConstraints { make in
            make.top.equalTo(barCharView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 40))
        }
    }

    func setDataCount(_ count: Int, range: UInt32) {
        let start = 0

        let yVals = (start ..< count + 1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            return BarChartDataEntry(x: Double(i), y: val)
        }

        var set1: BarChartDataSet!
        set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
        set1.colors = ChartColorTemplates.material()
//        set1.drawValuesEnabled = false

        let data = BarChartData(dataSet: set1)
//        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)

        data.barWidth = 1
        barCharView.data = data
        barCharView.fitBars = true

        //        chartView.setNeedsDisplay()
    }

    @objc private func changeDate(_ sender: UIButton) {
        let currentTag = sender.tag
        if currentTag == 1 {
            if _currentDate < Date.now.appendDay(date_dis: 10) {
                return
            } else {
                _currentDate = _currentDate.deleteADay()
            }
        } else {
            if _currentDate > Date.now.appendDay(date_dis: 17) {
                return
            } else {
                _currentDate = _currentDate.addADay()
            }
        }
        dateLabel.text = _currentDate.getDate()
        wedLabel.text = _currentDate.getWeek()
        monLabel.text = _currentDate.getMonth()
    }

    @objc
    private func book() {
        let arr = ["8:00 AM", "11:30 AM", "2:00 PM", "5:30PM", "7:00PM"]
        PickerViewManager.showSingleColPicker("Choose Time", data: arr, defaultSelectedIndex: 0, cancelAction: {}, sureAction: { [weak self] _, value in
            guard let strongSelf = self else { return }
            if let firstViewController = strongSelf.firstViewController as? MovieDetailController {
                let viewController = BookViewController()
                viewController.image = firstViewController.image
                viewController.movieName = firstViewController.movieName
                viewController.movieTime = value
                viewController.movieDate = strongSelf._currentDate.format(str: "M.dd.yyyy")
                strongSelf.firstViewController?.navigationController?.pushViewController(viewController, animated: true)
            }
        })
    }
}

extension UIView {
    public var firstViewController: UIViewController? {
        for view in sequence(first: superview, next: { $0?.superview }) {
            if let responder = view?.next, responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
        }
        return nil
    }
}
