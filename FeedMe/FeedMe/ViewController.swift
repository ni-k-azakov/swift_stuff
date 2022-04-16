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
    @IBOutlet weak var scheduleTable: UITableView!
    
    let orders = [
        "22.10 18:30 Травы, самовывоз",
        "29.10 15:00 Продукты, доставка",
        "01.11 14:50 Teremok, доставка",
        "12.11 17:38 KFC, самовывоз",
        "13.11 08:30 Макдудлс, доставка",
        "18.11 09:50 Вкусная еда, самовывоз",
        "02.12 18:00 ЖОПАиЖОПА, доставка"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("NIKAZ: TAPPED")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        cell.textLabel?.text = orders[indexPath.row]
        return cell
    }
}
