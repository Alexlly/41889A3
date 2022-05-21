//
//  BookViewController.swift
//  MovieList
//
//  Created by Junjie on 2022/5/15.
//

import Foundation
import UIKit

class BookViewController: UIViewController {
    public var movieName: String? {
        willSet(newValue) {
            if let name = newValue {
                titleLabel.text = name
            }
        }
    }

    public var image: UIImage?

    public var movieTime: String = ""

    public var movieDate: String = ""

    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        btn.setImage(UIImage(systemName: "arrow.backward", withConfiguration: largeConfig), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        return btn
    }()

    private lazy var sureButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("CHECK OUT", for: .normal)
        btn.backgroundColor = UIColor(rgb: 0x989ED8)
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(sure), for: .touchUpInside)
        return btn
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Joker(2019)"
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.headerReferenceSize = CGSize(width: 0, height: 10)
        collectionViewLayout.itemSize = CGSize(width: 35, height: 35)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01), collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private var stateArr: [[Bool]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: UIImage(named: "purple_back")!)

        initView()

        Array(0 ... 6).forEach { _ in
            stateArr.append(Array(0 ... 6).compactMap { _ in false })
        }
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

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(400)
        }

        view.addSubview(sureButton)
        sureButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(250)
        }
    }


    @objc
    private func popAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    private func sure() {
        let viewController = TicketViewController()
        viewController.movieDate = movieDate
        viewController.movieTime = movieTime
        viewController.image = image

        var info: [String] = []

        stateArr.enumerated().forEach { (itemIndex, item) in
            item.enumerated().forEach { (rowIndex, row) in
                if row {
                    let optionCh = Character(UnicodeScalar(96 + itemIndex + 1)!)
                    info.append("\(String(optionCh).uppercased())\(rowIndex + 1)")
                }
            }
        }
        viewController.movieName = movieName
        viewController.info = info
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BookViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        if indexPath.section == 0 {
            cell.bgview.backgroundColor = .clear
            cell.label.text = "\(indexPath.item)"
        } else {
            if indexPath.row == 0 || indexPath.row == 7 {
                cell.bgview.backgroundColor = .clear
                let optionCh = Character(UnicodeScalar(96 + indexPath.section)!)
                cell.label.text = String(optionCh).uppercased()
            } else {
                cell.label.text = nil
                if stateArr[indexPath.section - 1][indexPath.row - 1] {
                    cell.bgview.backgroundColor = UIColor(rgb: 0xaba6a8)
                } else {
                    cell.bgview.backgroundColor = .white
                }
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 && !(indexPath.row == 0 || indexPath.row == 7) {
            stateArr[indexPath.section - 1][indexPath.row - 1].toggle()
        }
        collectionView.reloadData()
    }
}

class CollectionViewCell: UICollectionViewCell {
    lazy var bgview: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(bgview)
        bgview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        bgview.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
