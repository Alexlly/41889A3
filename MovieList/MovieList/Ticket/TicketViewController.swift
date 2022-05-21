//
//  TicketViewController.swift
//  MovieList
//
//  Created by Bohui on 2022/5/15.
//

import Foundation
import UIKit

class TicketViewController: UIViewController {
    public var movieName: String? {
        willSet(newValue) {
            if let name = newValue {
                titleLabel.text = name
            }
        }
    }

    public var movieTime: String = ""

    public var movieDate: String = ""

    public var image: UIImage?

    public var info: [String] = []

    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        btn.setImage(UIImage(systemName: "arrow.backward", withConfiguration: largeConfig), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        return btn
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Joker(2019)"
        return label
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: UIImage(named: "purple_back")!)

        initView()
    }

    private func initView() {
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(80)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn.snp.centerY)
        }

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "YOUR TICKET:"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }

        let lineView = UIView()
        lineView.backgroundColor = .black
        lineView.layer.cornerRadius = 2.5
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(label.snp.bottom).offset(20)
            make.height.equalTo(5)
        }

        let logoImageView = UIImageView()
        view.addSubview(logoImageView)
        logoImageView.image = image
        logoImageView.snp.makeConstraints { make in
            make.left.equalTo(lineView).offset(20)
            make.right.equalTo(lineView).offset(-20)
            make.top.equalTo(lineView.snp.bottom)
            make.height.equalTo(350)
        }

        let maskView = UIView()
        maskView.backgroundColor = .gray
        maskView.alpha = 0.4
        logoImageView.addSubview(maskView)
        maskView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.text = "DATE：\(movieDate)"
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView).offset(140)
            make.left.equalTo(70)
        }

        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        timeLabel.text = "TIME：\(movieTime)"
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.left.equalTo(dateLabel)
        }

        let seatsLabel = UILabel()
        seatsLabel.font = UIFont.systemFont(ofSize: 15)
        seatsLabel.text = "SEATS：\(info.joined(separator: " "))"
        view.addSubview(seatsLabel)
        seatsLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.left.equalTo(dateLabel)
        }


        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = UIColor(rgb: 0xa8aaca)
        nameLabel.text = movieName
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(seatsLabel.snp.bottom).offset(20)
            make.left.equalTo(dateLabel)
        }

        let totalLabel = UILabel()
        totalLabel.font = UIFont.systemFont(ofSize: 15)
        totalLabel.text = "TOTAL：$\(info.count * 20)"
        view.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalTo(dateLabel)
        }
        
    }

    @objc
    private func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
