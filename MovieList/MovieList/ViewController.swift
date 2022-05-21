//
//  ViewController.swift
//  MovieList
//
//  Created by Yuhao on 2022/5/10.
//

import UIKit
import Shuffle_iOS
import SnapKit

class ViewController: UIViewController {
    
    private lazy var cardStack: SwipeCardStack = {
        let card = SwipeCardStack()
        card.delegate = self
        card.dataSource = self
        card.backgroundColor = UIColor.init(patternImage: UIImage(named: "purple_back")!)
        return card
    }()
    
    private var movies: [MovieDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = true
        
        movies = decodeFromJsonFile("movie")
        
        configureBackgroundGradient()
        layoutCardStackView()
        
    }
    
    private func configureBackgroundGradient() {
        let backgroundGray = UIColor(red: 244 / 255, green: 247 / 255, blue: 250 / 255, alpha: 1)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, backgroundGray.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func layoutCardStackView() {
        view.addSubview(cardStack)
        cardStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}

extension ViewController: SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .right]
//        card.backgroundColor = .red
        
            for direction in card.swipeDirections {
              card.setOverlay(TinderCardOverlay(direction: direction), forDirection: direction)
            }
        
        let tempView = MovieDescView(frame: .zero)
        tempView.imageName = movies[index].image
        tempView.movieName = movies[index].name
        tempView.movieType = "3D"
        tempView.themeName = movies[index].score
        tempView.typeName = movies[index].category
        tempView.describe = movies[index].desc
        card.content = tempView
        //
        //    let model = cardModels[index]
        //    card.content = TinderCardContentView(withImage: model.image)
        //    card.footer = TinderCardFooterView(withTitle: "\(model.name), \(model.age)", subtitle: model.occupation)
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return movies.count
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("Swiped all cards!")
    }
    
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        //    print("Undo \(direction) swipe on \(cardModels[index].name)")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        //    print("Swiped \(direction) on \(cardModels[index].name)")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card tapped")
        let vc = MovieDetailController()
        vc.movieUrl = movies[index].youtube
        vc.movieName = movies[index].name
        vc.movieType = "3D"
        vc.image = UIImage(named: movies[index].image)
        vc.themeName = movies[index].score
        vc.typeName = movies[index].category
        vc.describe = movies[index].desc
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
