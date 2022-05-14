//
//  MovieDescView.swift
//  MovieDemo
//
//  Created by Mason on 2022/5/10.
//

import UIKit

class MovieDescView: UIView {
    
    public var imageName: String? {
        willSet(newValue) {
            imageView.imageName = newValue
        }
    }
    
    public var movieName: String? {
        willSet(newValue) {
            imageView.movieName = newValue
        }
    }
    
    public var movieType: String? {
        willSet(newValue) {
            imageView.movieType = newValue
        }
    }
    
    public var themeName: String? {
        willSet(newValue) {
            imageView.themeName = newValue
        }
    }
    
    public var typeName: String? {
        willSet(newValue) {
            imageView.typeName = newValue
        }
    }
    
    public var describe: String? {
        willSet(newValue) {
            imageView.describe = newValue
        }
    }

    private lazy var imageView: MovieCardView = {
        let imageView = MovieCardView()
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .white
        return imageView
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
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.screenHeight - 250)
            make.width.equalTo(UIScreen.screenWidth - 80)
        }
    }

}
