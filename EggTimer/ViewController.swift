//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    let eggTime = [
        "Soft": 6,
        "Medium": 10,
        "Hard": 15
    ]
    private var totalTime = 0
    private var secondsPassed = 0
    private var timer = Timer()
    
    //MARK: - Lify Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        configureUI()
    }
    
    //MARK: - UILabel

    private var testLabel: UILabel = {
        var testLabel = UILabel()
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.textColor = UIColor.black
        testLabel.adjustsFontSizeToFitWidth = true
        testLabel.sizeToFit()
        testLabel.text = "How do you like your eggs?"
        testLabel.textAlignment = .center
        return testLabel
    }()
    
    //MARK: - UIButton
    
    private var buttonSoftEgg: UIButton = {
        var buttonSoftEgg = UIButton()
        buttonSoftEgg = UIButton(type: .system)
        buttonSoftEgg.translatesAutoresizingMaskIntoConstraints = false
        buttonSoftEgg.setBackgroundImage(UIImage(named: "soft_egg"), for: .normal)
        buttonSoftEgg.setTitle("Soft", for: .normal)
        buttonSoftEgg.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        buttonSoftEgg.tintColor = UIColor.white
        buttonSoftEgg.addTarget(self, action: #selector(pressedMedium(sender:)), for: .touchUpInside)
        return buttonSoftEgg
    }()
    
    private var buttonMediumEgg: UIButton = {
        var buttonMediumEgg = UIButton()
        buttonMediumEgg = UIButton(type: .system)
        buttonMediumEgg.translatesAutoresizingMaskIntoConstraints = false
        buttonMediumEgg.setBackgroundImage(UIImage(named: "medium_egg"), for: .normal)
        buttonMediumEgg.setTitle("Medium", for: .normal)
        buttonMediumEgg.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        buttonMediumEgg.tintColor = UIColor.white
        buttonMediumEgg.addTarget(self, action: #selector(pressedMedium(sender:)), for: .touchUpInside)
        return buttonMediumEgg
    }()
    
    private var buttonHardEgg: UIButton = {
        var buttonHardEgg = UIButton()
        buttonHardEgg = UIButton(type: .system)
        buttonHardEgg.translatesAutoresizingMaskIntoConstraints = false
        buttonHardEgg.setBackgroundImage(UIImage(named: "hard_egg"), for: .normal)
        buttonHardEgg.setTitle("Hard", for: .normal)
        buttonHardEgg.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        buttonHardEgg.tintColor = UIColor.white
        buttonHardEgg.addTarget(self, action: #selector(pressedMedium(sender:)), for: .touchUpInside)
        return buttonHardEgg
    }()
    
    private var progressView: UIProgressView = {
        var progressView = UIProgressView()
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.0, animated: false)
        progressView.progressTintColor = UIColor.green
        progressView.trackTintColor = UIColor.gray
       return progressView
    }()
    
    //MARK: - Methods
    
    @objc private func pressedMedium(sender: UIButton) {
        
        timer.invalidate()
        
        guard let hardness = sender.currentTitle else { return }
        
        totalTime = eggTime[hardness]!
        
        progressView.progress = 0.0
        secondsPassed = 0
        testLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            print(percentageProgress)
            progressView.progress = Float(percentageProgress)
            print(Float(percentageProgress))
            
        } else {
            timer.invalidate()
            testLabel.text = "It's done"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
    }
    
    private func configureUI() {
        addSubView()
        createBound()
    }
    
    private func addSubView() {
        view.addSubview(testLabel)
        view.addSubview(buttonSoftEgg)
        view.addSubview(buttonMediumEgg)
        view.addSubview(buttonHardEgg)
        view.addSubview(progressView)
    }
    
    private func createBound() {
        createTestLabelAncor()
        createButtonSoftEggAnchor()
        createButtonMediumEggAnchor()
        createButtonHardEggAnchor()
        createProgressViewAnchor()
    }
    
    private func createTestLabelAncor() {
        NSLayoutConstraint.activate([
            testLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            testLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            testLabel.bottomAnchor.constraint(equalTo: buttonMediumEgg.topAnchor),
            testLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func createButtonSoftEggAnchor() {
        NSLayoutConstraint.activate([
            buttonSoftEgg.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonSoftEgg.heightAnchor.constraint(equalToConstant: 150),
            buttonSoftEgg.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            buttonSoftEgg.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 1/3.5)
        ])
    }
    
    private func createButtonMediumEggAnchor() {
        NSLayoutConstraint.activate([
            buttonMediumEgg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonMediumEgg.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonMediumEgg.heightAnchor.constraint(equalToConstant: 150),
            buttonMediumEgg.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 1/3.5)
        ])
    }
    
    private func createButtonHardEggAnchor() {
        NSLayoutConstraint.activate([
            //buttonHardEgg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            buttonHardEgg.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            buttonHardEgg.widthAnchor.constraint(equalTo:self.view.layoutMarginsGuide.widthAnchor, multiplier: 1/3.5),
            buttonHardEgg.heightAnchor.constraint(equalToConstant: 150),
            buttonHardEgg.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func createProgressViewAnchor() {
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -100),
            progressView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
}
