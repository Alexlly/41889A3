//
//  MovieBottomView.swift
//  MovieDemo
//
//  Created by Jiawei on 2022/5/14.
//

import UIKit

class MovieBottomView: UIView {
    
    public var actionBlock: () -> Void = {  }
    
    private lazy var sessonTimeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setTitle("SESSION TIMES", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(actionObj), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    public var movieName: String? {
        willSet(newValue) {
            if let name = newValue {
                titleLabel.text = name
            }
        }
    }
    
    public var movieType: String? {
        willSet(newValue) {
            if let name = newValue {
                threeDLabel.text = name
            }
        }
    }
    
    public var themeName: String? {
        willSet(newValue) {
            if let name = newValue {
                themeLabel.text = name
            }
        }
    }
    
    public var typeName: String? {
        willSet(newValue) {
            if let name = newValue {
                typeLabel.text = name
            }
        }
    }
    
    public var describe: String? {
        willSet(newValue) {
            if let name = newValue {
                describeLabel.text = name
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = themeColor
        return label
    }()
    
    private lazy var threeDLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var describeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(20)
        }
        
        addSubview(threeDLabel)
        threeDLabel.snp.makeConstraints { make in
            make.right.equalTo(-60)
            make.top.equalTo(12)
        }
        
        addSubview(themeLabel)
        themeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(threeDLabel)
            make.top.equalTo(threeDLabel.snp.bottom).offset(5)
        }
        
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        addSubview(sessonTimeBtn)
        sessonTimeBtn.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 120, height: 20))
        }
        
        addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalTo(sessonTimeBtn.snp.centerY)
        }
        
        addSubview(describeLabel)
        describeLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(sessonTimeBtn.snp.bottom).offset(15)
            make.height.equalTo(200)
//            make.bottom.equalTo(-40)
        }
    }
    
    @objc private func actionObj() {
        actionBlock()
    }
}
