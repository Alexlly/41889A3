//
//  MovieDetailController.swift
//  MovieDemo
//
//  Created by Mason on 2022/5/11.
//

import UIKit
import YoutubePlayerView

class MovieDetailController: UIViewController {
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    public var movieUrl: String = ""
    
    public var movieName: String? {
        willSet(newValue) {
            if let name = newValue {
                contentView.movieName = name
                titleLabel.text = name
            }
        }
    }
    
    public var movieType: String? {
        willSet(newValue) {
            if let name = newValue {
                contentView.movieType = name
            }
        }
    }
    
    public var themeName: String? {
        willSet(newValue) {
            if let name = newValue {
                contentView.themeName = name
            }
        }
    }
    
    public var typeName: String? {
        willSet(newValue) {
            if let name = newValue {
                contentView.typeName = name
            }
        }
    }
    
    public var describe: String? {
        willSet(newValue) {
            if let name = newValue {
                contentView.describe = name
            }
        }
    }
    
    private var isHidden = false
    
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
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var playerView: YoutubePlayerView = {
        let player = YoutubePlayerView()
        player.backgroundColor = .black
        player.layer.masksToBounds = true
        return player
    }()
    
    private lazy var contentView: MovieBottomView = {
        let view = MovieBottomView()
        view.isHidden = false
        view.layer.cornerRadius = 8
//        view.movieName = "Joker(2019)"
//        view.movieType = "3D"
//        view.themeName = "IMDB: 8.5"
//        view.typeName = "Crime,Drama, Thriller"
//        view.describe = """
//Joker is the first live-action theatrical Batman film to receive an R rating from the Motion Picture Association. Joker had its world premiere at the 76th Venice International Film Festival on August 31, 2019, where it won the Golden Lion, and was released in the United States on October 4, 2019.
//"""
        return view
    }()
    
    private lazy var sessionView: SessionDateView = {
        let view = SessionDateView()
        view.layer.cornerRadius = 8
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "purple_back")!)
        
        initView()
        
        playerView.delegate = self
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
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(180)
            make.height.equalTo(300)
        }
        
        backgroundView.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(50)
            make.height.equalTo(200)
        }
        
        let playerVars: [String: Any] = [
            "controls": 1,
            "modestbranding": 1,
            "playsinline": 1,
            "rel": 0,
            "showinfo": 0,
            "autoplay": 1
        ]
        playerView.loadWithVideoId(movieUrl, with: playerVars)
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(backgroundView.snp.bottom).offset(20)
            make.height.equalTo(400)
        }
        
        contentView.actionBlock = { [weak self] in
            self?.sessionView.isHidden = false
            self?.contentView.isHidden = true
            self?.isHidden = true
        }
        
        view.addSubview(sessionView)
        sessionView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(backgroundView.snp.bottom).offset(20)
            make.height.equalTo(400)
        }
    }
    
    @objc func popAction() {
        if isHidden {
            sessionView.isHidden = true
            contentView.isHidden = false
            isHidden = false
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieDetailController: YoutubePlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YoutubePlayerView) {
        print("Ready")
        playerView.play()
    }

    func playerView(_ playerView: YoutubePlayerView, didChangedToState state: YoutubePlayerState) {
        print("Changed to state: \(state)")
    }

    func playerView(_ playerView: YoutubePlayerView, didChangeToQuality quality: YoutubePlaybackQuality) {
        print("Changed to quality: \(quality)")
    }

    func playerView(_ playerView: YoutubePlayerView, receivedError error: Error) {
        print("Error: \(error)")
    }

    func playerView(_ playerView: YoutubePlayerView, didPlayTime time: Float) {
        print("Play time: \(time)")
    }
}
