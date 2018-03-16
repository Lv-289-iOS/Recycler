//
//  EasterEgg.swift
//  Recycler
//
//  Created by David on 3/15/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class GameVC: UIViewController {
    
    var gameStruct = MiniGameStruct()
    let imageHeight = 60 as CGFloat
    let imageWidth = 60 as CGFloat
    let gameOverlay = UIView()
    
    @objc func createNewGame() {
        gameStruct = MiniGameStruct()
        addGameOverlay(number: gameStruct.numberOfImages)
    }
    
    func addGameOverlay(number: Int) {
        
        gameOverlay.frame = self.view.frame
        gameOverlay.backgroundColor = UIColor.clear
        UIApplication.shared.keyWindow?.addSubview(gameOverlay)
        
        let images = gameStruct.getImages()
        let rangeY = self.view.frame.height - imageHeight
        let rangeX = self.view.frame.width - imageWidth
        
        for index in 0..<images.count {
            let randomAngle = arc4random_uniform(1000)
            let angle = Double(2 * Double.pi * 1000)/Double(randomAngle)
            
            let imageView = UIImageView(image: images[index])
            
            let randPos = random(rangeX: Int(rangeX), rangeY: Int(rangeY))
            imageView.frame = CGRect(origin: randPos, size: gameStruct.imageSize)
            imageView.addTapGesture()
            imageView.isUserInteractionEnabled = true
            gameOverlay.addSubview(imageView)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveLinear,
                           animations:
                { () -> Void in
                    for view in self.gameOverlay.subviews {
                        view.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
                    }
            },
                           completion: nil)
        }
    }
    
    private func random(rangeX: Int, rangeY: Int) -> CGPoint {
        return CGPoint(x: Int(Int(arc4random()) % rangeX)+Int(imageWidth/2), y: Int(Int(arc4random()) % rangeY)+Int(imageHeight/2))
    }
}


extension UIView {
    
    func addGameToVC() {
        let del = UIApplication.shared.delegate as? AppDelegate
        guard let target = del?.game else {
            print("cannot find target")
            return
        }
        let tap = UITapGestureRecognizer(target: target, action: #selector(target.createNewGame))
        tap.numberOfTapsRequired = 3
        self.addGestureRecognizer(tap)
    }
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeView))
        self.addGestureRecognizer(tap)
    }
    @objc func removeView() {
        let del = UIApplication.shared.delegate as? AppDelegate
        guard let target = del?.game else {
            print("cannot find target")
            return
        }
        self.removeFromSuperview()
        target.gameStruct.numberOfImages = target.gameStruct.numberOfImages-1
        if target.gameStruct.numberOfImages == 0 {
            target.gameOverlay.removeFromSuperview()
        }
        
    }
}

