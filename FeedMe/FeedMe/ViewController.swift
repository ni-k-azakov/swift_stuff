//
//  ViewController.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 26.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardInfo: UIView!
    @IBOutlet weak var cardCheqeue: UIView!
    @IBOutlet weak var cardScroll: UIScrollView!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
    }
    
    private func setupCard() {
        openButton.isHidden = false
        closeButton.isHidden = true
    }
    
    @IBAction func openCard(_ sender: UIButton) {
        scrollToPage(page: 1, animated: true)
        openButton.isHidden = true
        closeButton.isHidden = false
    }
    
    @IBAction func closeCard(_ sender: UIButton) {
        scrollToPage(page: 0, animated: true)
        openButton.isHidden = false
        closeButton.isHidden = true
    }
    
    private func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = cardScroll.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        cardScroll.scrollRectToVisible(frame, animated: animated)
    }
}

