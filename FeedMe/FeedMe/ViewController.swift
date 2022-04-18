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
    @IBOutlet weak var orderTable: UITableView!
    
    var orders: [ScheduleNote] = []
    var cheque: [OrderNote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        fillOrders()
        fillCheque()
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        orderTable.delegate = self
        orderTable.dataSource = self
        scheduleTable.contentInsetAdjustmentBehavior = .never
        scheduleTable.sectionHeaderTopPadding = 0
        orderTable.sectionHeaderTopPadding = 10
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
    
    private func fillOrders() {
        var note = ScheduleNote(logo: UIImage.init(systemName: "cup.and.saucer.fill") ?? UIImage.checkmark, date: "22.10 18:30", name: "Травы", type: .SELF)
        orders.append(note)
        note = ScheduleNote(logo: UIImage.init(systemName: "trash") ?? UIImage.checkmark, date: "29.10 15:00", name: "Продукты", type: .DELIVERY)
        orders.append(note)
        note = ScheduleNote(logo: UIImage.init(systemName: "paperplane.fill") ?? UIImage.checkmark, date: "01.11 14:50", name: "Teremok", type: .DELIVERY)
        orders.append(note)
        note = ScheduleNote(logo: UIImage.init(systemName: "calendar") ?? UIImage.checkmark, date: "12.11 17:38", name: "KFC", type: .SELF)
        orders.append(note)
        note = ScheduleNote(logo: UIImage.init(systemName: "book.fill") ?? UIImage.checkmark, date: "13.11 08:30", name: "Макдудлс", type: .DELIVERY)
        orders.append(note)
        note = ScheduleNote(logo: UIImage.init(systemName: "rosette") ?? UIImage.checkmark, date: "18.11 09:50", name: "Вкусная еда", type: .SELF)
        orders.append(note)
        note = ScheduleNote(logo: UIImage.init(systemName: "person.fill") ?? UIImage.checkmark, date: "02.12 18:00", name: "ЖОПАиЖОПА", type: .DELIVERY)
        orders.append(note)
        
    }
    
    private func fillCheque() {
        var note = OrderNote(product: "Americano", amount: 1, price: 100)
        cheque.append(note)
        note = OrderNote(product: "Sugar", amount: 2, price: 10)
        cheque.append(note)
        note = OrderNote(product: "Latte", amount: 1, price: 120)
        cheque.append(note)
        note = OrderNote(product: "Croissant", amount: 2, price: 120)
        cheque.append(note)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == scheduleTable {
            print("NIKAZ: TAPPED")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == scheduleTable {
            return orders.count
        } else {
            return cheque.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == orderTable {
            let header = UITableViewCell()
            header.textLabel?.text = "12XF3G" // ...
            header.textLabel?.textColor = UIColor.systemGreen
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            header.backgroundColor = UIColor.init(named: "dark_grey")!
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == orderTable {
            return 40
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == scheduleTable {
            let scheduleCell = tableView.dequeueReusableCell(withIdentifier: "scheduleNote", for: indexPath) as! ScheduleCell
            let order = orders[indexPath.row]
            scheduleCell.setLogo(order.getLogo())
            scheduleCell.setInfo(order.getString())
            return scheduleCell
        } else {
            let orderCell = tableView.dequeueReusableCell(withIdentifier: "orderNote", for: indexPath) as! OrderCell
            let item = cheque[indexPath.row]
            orderCell.setInfo(product: item.getProduct(), amount: item.getAmount(), price: item.getPrice())
            return orderCell
        }
    }
}
