//
//  ViewController.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 26.03.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var cardInfo: UIView!
    @IBOutlet weak var cardCheqeue: UIView!
    @IBOutlet weak var cardScroll: UIScrollView!
    @IBOutlet weak var cardBrandLogo: UIImageView!
    @IBOutlet weak var cardBrandName: UILabel!
    @IBOutlet weak var cardOrderType: UILabel!
    @IBOutlet weak var cardAdress: UILabel!
    @IBOutlet weak var cardDate: UILabel!
    @IBOutlet weak var cardTime: UILabel!
    
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var orderTable: UITableView!
    @IBOutlet weak var totalSum: UILabel!
    @IBOutlet weak var ordersAmountLabel: UILabel!
    
    var currentOrder: Int = -1
    var nextOrder = -1
    var orders: [Order] = []
    var toDoOrders: [CDNote] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromDb()
        fillOrders()
        fillCheque()
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        orderTable.delegate = self
        orderTable.dataSource = self
        scheduleTable.contentInsetAdjustmentBehavior = .never
        scheduleTable.sectionHeaderTopPadding = 0
        orderTable.sectionHeaderTopPadding = 10
        setupCard()
    }
    
    private func setupCard() {
        openButton.isHidden = false
        closeButton.isHidden = true
        totalSum.text = "Сумма заказа: " + orders[0].getTotalSum()
        ordersAmountLabel.text = String(orders.count)
        nextOrder = 0 // TODO: вычислять след заказ
        if nextOrder != -1 {
            let tempOrder = orders[nextOrder]
            cardBrandName.text = tempOrder.getBrand().name
            cardAdress.text = tempOrder.getAdress()
//            cardBrandLogo.image = tempOrder.getBrand().logo
            cardOrderType.text = tempOrder.orderType == .SELF ? "Самовывоз" : "Доставка"
            
        } else {
            cardBrandName.text = ""
        }
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
    
    @IBAction func generateOrder(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Note", in: managedContext)
        let note = CDNote(entity: entity!, insertInto: managedContext)
        note.brand = "TEMP NAME \(toDoOrders.count)"
        note.rating = 5
        note.adress = "GDE-TO DALEKO"
        note.id = NSNumber(integerLiteral: toDoOrders.count)
        note.date = Date()
        do {
            try managedContext.save()
            toDoOrders.append(note)
        } catch {
          print("Could not save \(error)")
        }
        fillOrders()
        fillCheque()
        setupCard()
        self.scheduleTable.reloadData()
    }
    
    private func loadFromDb() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = CDNote.fetchRequest()
        do {
            let results = try managedContext.fetch(request) as NSArray
            for result in results {
                toDoOrders.append(result as! CDNote)
            }
        } catch {
            print("FAILED TO LOAD: \(error)")
        }
    }
    
    @IBAction func deleteFromDb() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results = try managedContext.fetch(request) as NSArray
            for result in results {
                managedContext.delete(result as! CDNote)
            }
            try managedContext.save()
        } catch {
            print("FAILED TO LOAD: \(error)")
            return
        }
        toDoOrders = []
        fillOrders()
        fillCheque()
        setupCard()
        self.scheduleTable.reloadData()
    }
    
    private func fillOrders() {
        orders.removeAll()
        let note = Order(brand: Brand(logo: "sdf)", name: "Coffe'n'Coffee", rating: "5"), adress: "г. Санкт-Петербург, Кронверкский проспект, д.1, кв.5", orderType: .SELF)
        orders.append(note)
        for toDoOrder in toDoOrders {
            orders.append(
                Order(brand: Brand(logo: "sdf", name: toDoOrder.brand, rating: String(toDoOrder.rating?.intValue ?? 0)), adress: toDoOrder.adress, orderType: .DELIVERY)
            )
        }
    }
    
    
    
    private func fillCheque() {
        orders[0].items.append(Item(name: "Americano", amount: 1, price: 100))
        orders[0].items.append(Item(name: "Sugar", amount: 2, price: 10))
        orders[0].items.append(Item(name: "Latte", amount: 1, price: 120))
        orders[0].items.append(Item(name: "Croissant", amount: 2, price: 120))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is OrderController {
            if currentOrder == -1 {
                return
            }
            let vc = segue.destination as? OrderController
            let order = orders[currentOrder]
            vc?.logo = UIImage(named: order.getBrand().logo) ?? UIImage.checkmark
            vc?.adress = order.getAdress()
            vc?.brandName = order.getBrand().name
            vc?.catleryAmount = String(order.catleryAmount)
            vc?.date = order.getDateString()
            vc?.orderType = order.orderType == .SELF ? "Самовывоз" : "Доставка"
            vc?.paymentType = order.paymentType == .CARD ? "Карта" : "Наличные"
            vc?.items = order.items.reversed()
        } else if segue.destination is CreateOrderController {
            let vc = segue.destination as? CreateOrderController
            if segue.identifier == "CreateOrderDelivery" {
                vc?.header = "Доставка"
            } else if segue.identifier == "CreateOrderSelf" {
                vc?.header = "Самовывоз"
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == scheduleTable {
            currentOrder = indexPath.row
            self.performSegue(withIdentifier: "ShowOrder", sender: self)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == scheduleTable {
            return orders.count
        } else {
            return orders[0].items.count
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
            scheduleCell.setLogo(UIImage(named: order.getBrand().logo) ?? UIImage.checkmark)
            scheduleCell.setInfo(order.getString())
            if order.hasTroubles() {
                scheduleCell.enableTrouble()
            } else {
                scheduleCell.disableTrouble()
            }
            return scheduleCell
        } else {
            let orderCell = tableView.dequeueReusableCell(withIdentifier: "orderNote", for: indexPath) as! OrderCell
            let item = orders[0].items[indexPath.row] // поменять на близжайший заказ
            orderCell.setInfo(product: item.getName(), amount: item.getAmount(), price: item.getPrice())
            return orderCell
        }
    }
}
