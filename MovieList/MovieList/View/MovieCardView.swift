//
//  MovieCardView.swift
//  MovieDemo
//
//  Created by Mason on 2022/5/10.
//

import UIKit

class MovieCardView: UIView {
    
    public var imageName: String? {
        willSet(newValue) {
            if let name = newValue {
                imageView.image = UIImage(named: name)
            }
        }
    }
    
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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(350)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        addSubview(threeDLabel)
        threeDLabel.snp.makeConstraints { make in
            make.right.equalTo(-60)
            make.top.equalTo(imageView.snp.bottom).offset(12)
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
        
        addSubview(describeLabel)
        describeLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(typeLabel.snp.bottom).offset(18)
            make.height.equalTo(200)
//            make.bottom.equalTo(-40)
        }
    }
}
