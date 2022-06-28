//
//  ViewController.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 09.06.2022.
//

import UIKit
import UberRides
import CoreLocation
import UberCore

class ViewController: UIViewController {
    private var isInfoFolded = true
    private var api = TaxiComparatorApi()
    private var textFrom = ""
    private var textTo = ""
    private var tempCategory = "Эконом"
    private(set) var taxiViewList: [TaxiStatView] = []
    private(set) var bestPrice = Int.max
    private(set) var worstPrice = 0
    private var saveIsInProgress = false
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoCard: UIView!
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var infoStack: UIStackView!
    @IBOutlet weak var infoFiller: UIView!
    @IBOutlet weak var routeLineView: RouteLineView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var bestTaxiLogo: UIImageView!
    @IBOutlet weak var bestTaxiPrice: UILabel!
    @IBOutlet weak var logoStack: UIStackView!
    @IBOutlet weak var costRange: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var cardInfoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var shotWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var shotConfirmCard: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleInfo()
        setupViews()
        decorate()
    }
    
    private func setupViews() {
        infoContainer.isHidden = true
        errorMessageLabel.isHidden = true
        fromTextField.delegate = self
        toTextField.delegate = self
        typeLabel.text = tempCategory
        fromTextField.placeholder = "Откуда?"
        toTextField.placeholder = "Куда?"
    }
    
    private func toggleInfo() {
        if !infoCard.isHidden {
            infoCard.isHidden = true
            infoFiller.isHidden = true
        } else {
            infoCard.alpha = 0.0
            infoFiller.alpha = 0.0
            infoCard.isHidden = false
            infoFiller.isHidden = false
            UIView.animate(withDuration: 1, animations: {
                self.infoCard.alpha = 1.0
                self.infoFiller.alpha = 1.0
            }) { finish in
                print("UNHIDDEN CARD")
            }
        }
    }
    
    private func showInfoContainer() {
        infoContainer.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.infoContainer.alpha = 1.0
        }) { finish in
            print("UNHIDDEN CONTAINER")
        }
    }
    
    private func decorate() {
        routeLineView.setLineWidth(2).setLineCurve(20).setLineColor(.systemYellow).drawLine()
    }
    
    @IBAction func findAvailableTaxi(_ sender: UIButton) {
        let queue = DispatchQueue.global(qos: .utility)
        textFrom = fromTextField.text ?? ""
        textTo = toTextField.text ?? ""
        taxiViewList = []
        // TODO: убрать базовые значения
        textFrom = textFrom == "" ? "Татарский переулок 1, Санкт-Петербург, Россия" : textFrom
        textTo = textTo == "" ? "Проспект сизова 32/1, Санкт-Петербург, Россия" : textTo
        //
        if infoCard.isHidden {
            self.isInfoFolded = true
            toggleInfo()
        }
        errorMessageLabel.isHidden = true
        infoContainer.isHidden = true
        loadIndicator.startAnimating()
        if !isInfoFolded {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.cardInfoTopConstraint.constant = 130
                self.view.layoutIfNeeded()
            }
            self.isInfoFolded.toggle()
        }
        queue.async {
            let responses = self.api.getTaxiResponses(fromAdress: self.textFrom, toAdress: self.textTo)
            DispatchQueue.main.async {
                for child in self.infoStack.arrangedSubviews {
                    child.removeFromSuperview()
                }
                // Добавить сортировку
                switch responses {
                case .success(let responses):
                    for response in responses {
                        var brandName = response.key
                        var brandLogo = ""
                        let drivingTime = response.value.timeInSeconds
                        var prices: Array<(key: String, value: Int)> = []
                        switch response.key {
                        case "WhichTaxi":
                            brandLogo = "whichway_logo"
                            var costs: [String: Int] = [:]
                            for cost in response.value.costs {
                                switch cost.key {
                                case "СуперКомфорт":
                                    costs["Комфорт+"] = cost.value
                                default:
                                    costs[cost.key] = cost.value
                                }
                            }
                            prices = costs.sorted { $0.value < $1.value }
                        case "AnotherTaxi":
                            brandName = "Ситимобил"
                            brandLogo = "sitimobil_logo"
                        case "FairTaxi":
                            brandName = "Убер"
                            brandLogo = "uber_logo"
                            var costs: [String: Int] = [:]
                            for cost in response.value.costs {
                                switch cost.key {
                                case "economy":
                                    costs["Эконом"] = cost.value
                                case "comfort":
                                    costs["Комфорт"] = cost.value
                                case "comfort+":
                                    costs["Комфорт+"] = cost.value
                                case "business":
                                    costs["Бизнес"] = cost.value
                                case "vip":
                                    costs["VIP"] = cost.value
                                default:
                                    costs[cost.key] = cost.value
                                }
                            }
                            prices = costs.sorted { $0.value < $1.value }
                        default:
                            print("TAXI RESPONSE ERROR: no such taxi (\(response.key))")
                        }
                        self.taxiViewList.append(TaxiStatView(logoName: brandLogo, brandName: brandName, categoriesWithPrices: prices, time: drivingTime))
                    }
                    self.updateTaxiResponse(by: self.tempCategory)
                    self.loadIndicator.stopAnimating()
                    self.showInfoContainer()
                    print("GET TAXI RESPONSES SUCCESS: ", self.taxiViewList)
                case .failure(let error):
                    self.loadIndicator.stopAnimating()
                    self.errorMessageLabel.text = "Произошла ошибка. Проверьте соединение и правильность введённых данных"
                    self.errorMessageLabel.isHidden = false
                    print("GET TAXI RESPONSES ERROR: ", error)
                }
            }
        }
    }
    
    func updateTaxiResponse(by category: String) {
        for child in infoStack.arrangedSubviews {
            child.removeFromSuperview()
        }
        for view in getSortedTaxiViewList(list: taxiViewList, category: category) {
            infoStack.addArrangedSubview(view)
        }
        
        for child in logoStack.arrangedSubviews {
            child.removeFromSuperview()
        }
        for view in getSortedTaxiViewList(list: taxiViewList, category: category) {
            logoStack.addArrangedSubview(generateLogoSubview(logoString: view.logoName))
        }
        
        bestPrice = Int.max
        worstPrice = 0
        
        for view in taxiViewList {
            var costs: [String: Int] = [:]
            for item in view.stat {
                costs[item.key] = item.value
            }
            guard let cost = costs[tempCategory] else {
                continue
            }
            let tempPrice = cost
            UIView.transition(with: bestTaxiLogo, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.bestTaxiLogo.image = tempPrice < self.bestPrice ? UIImage(named: view.logoName) : self.bestTaxiLogo.image
            }) { finish in
                print("CHANGED BEST TAXI IMAGE")
            }
            bestTaxiLogo.image = tempPrice < bestPrice ? UIImage(named: view.logoName) : bestTaxiLogo.image
            bestPrice = tempPrice < bestPrice ? tempPrice : bestPrice
            worstPrice = tempPrice > worstPrice ? tempPrice : worstPrice
        }
        if bestPrice > worstPrice {
            UIView.transition(with: bestTaxiLogo, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.bestTaxiLogo.image = UIImage(systemName: "figure.walk")
                self.bestTaxiLogo.tintColor = UIColor.black
            }) { finish in
                print("CHANGED BEST TAXI IMAGE")
            }
            UIView.transition(with: bestTaxiPrice, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.bestTaxiPrice.text = "Бесплатно"
            }) { finish in
                print("CHANGED BEST PRICE: Бесплатно")
            }
            UIView.transition(with: costRange, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.costRange.text = "Недоступно"
            }) { finish in
                print("CHANGED COST RANGE:", "Недоступно")
            }
        } else {
            UIView.transition(with: bestTaxiPrice, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.bestTaxiPrice.text = "\(self.bestPrice)₽"
            }) { finish in
                print("CHANGED BEST PRICE: \(self.bestPrice)")
            }
            UIView.transition(with: costRange, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.costRange.text = self.bestPrice != self.worstPrice ? "\(self.bestPrice)₽-\(self.worstPrice)₽" : "\(self.bestPrice)₽"
            }) { finish in
                print("CHANGED COST RANGE:", self.costRange.text)
            }
        }
    }
    
    func getSortedTaxiViewList(list: [TaxiStatView], category: String) -> [TaxiStatView] {
        return list.sorted { (Dictionary(uniqueKeysWithValues: $0.stat)[category] ?? Int.max, $0.drivingTime < 0 ? Int.max : $0.drivingTime) < (Dictionary(uniqueKeysWithValues: $1.stat)[category] ?? Int.max, $1.drivingTime < 0 ? Int.max : $1.drivingTime) }
    }
    
    func generateLogoSubview(logoString: String) -> UIImageView {
        let view = UIImageView()
        let _ = view.setHeightConstraint(constant: 23).setWidthConstraint(constant: 23)
        print(logoString)
        view.image = UIImage(named: logoString)
        return view
    }
    
    @IBAction func savePricing(_ sender: UIView) {
        if saveIsInProgress {
            return
        }
        saveToFile()
        saveIsInProgress.toggle()
        let constant = max(infoCard.bounds.width, infoCard.bounds.height)
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut, .autoreverse], animations: {
            self.shotWidthConstraint.constant = constant + 50
            self.shotConfirmCard.layer.cornerRadius = (constant + 50) / 2
            self.view.layoutIfNeeded()
        }) { finish in
            self.shotWidthConstraint.constant = 0
            self.shotConfirmCard.layer.cornerRadius = 0
            self.saveIsInProgress.toggle()
        }
    }
    
    func saveToFile() {
        var stringToSave = ""
        for view in taxiViewList {
            stringToSave += "brand: \(view.brandName)\nseconds: \(view.drivingTime)\n"
            for item in view.stat {
                stringToSave += "\(item.key): \(item.value)"
                if item != view.stat.last! {
                    stringToSave += ", "
                } else {
                    stringToSave += "\n"
                }
            }
        }
        print("STRING TO SAVE\n\(stringToSave)")
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent("taxi.pricing")

        if let stringData = stringToSave.data(using: .utf8) {
            try? stringData.write(to: path)
        }
    }
    
    @IBAction func hideKeyboard(recognizer: UITapGestureRecognizer) {
        fromTextField.endEditing(true)
        toTextField.endEditing(true)
    }
    
    @IBAction func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        let direction = recognizer.direction
        guard direction == .down && !isInfoFolded || direction == .up && isInfoFolded else {
            return
        }
        guard !infoContainer.isHidden else {
            return
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.cardInfoTopConstraint.constant = direction == .down ? 130 : recognizer.view!.bounds.height
            self.view.layoutIfNeeded()
        }
        self.isInfoFolded.toggle()
    }
    
    @IBAction func HandleCategorySwipe(recognizer: UISwipeGestureRecognizer) {
        // TODO: сделать изменение картинки на кнопке, а не такста
        let direction = recognizer.direction
        guard direction == .left || direction == .right else {
            return
        }
        print("CATEGORY CHANGE: left == \(direction == .left), right == \(direction == .right)")
        var animationOption = UIView.AnimationOptions.transitionCurlUp
        if direction == .left {
            animationOption = .transitionCurlUp
        } else {
            animationOption = .transitionCurlDown
        }
        switch tempCategory {
        case "Эконом":
            if direction == .left {
                tempCategory = "Комфорт"
            } else {
                return
            }
        case "Комфорт":
            tempCategory = direction == .left ? "Комфорт+" : "Эконом"
        case "Комфорт+":
            tempCategory = direction == .left ? "Бизнес" : "Комфорт"
        case "Бизнес":
            tempCategory = direction == .left ? "VIP" : "Комфорт+"
        case "VIP":
            if direction == .right {
                tempCategory = "Бизнес"
            } else {
                return
            }
        default:
            print("UNKNOWN TAXI CATEGORY IN SWIPE HANDLER ERROR: \(tempCategory)")
        }
        UIView.transition(with: typeLabel, duration: 0.5, options: animationOption, animations: {
            self.typeLabel.text = self.tempCategory
        }) { finish in
            print("CHANGED CATEGORY: \(self.tempCategory)")
        }
        typeLabel.text = tempCategory
        updateTaxiResponse(by: tempCategory)
        // TODO: прикрутить изменение картинки
//        var image: UIImage!
//        switch tempCategory {
//        case "Эконом":
//           image = UIImage(systemName: "car")
//        case "Комфорт":
//            image = UIImage(named: "yandex_logo")
//        case "Комфорт+":
//            image = UIImage(named: "comfort_plus_taxi")
//        case "Бизнес":
//            image = UIImage(named: "premium_taxi")
//        default:
//            print("UNKNOWN TAXI CATEGORY IN SWIPE HANDLER ERROR: \(self.tempCategory)")
//            return
//        }
//        image = image.withTintColor(.black)
//        orderButton.imageView?.contentMode = .scaleAspectFit
//        orderButton.contentMode = .scaleAspectFit
//        self.orderButton.setImage(image, for: .normal)
//        UIView.transition(with: orderButton.imageView!, duration: 0.5, options: animationOption, animations: {
//            self.orderButton.setImage(image, for: .normal)
//        }) { finish in
//            print("CHANGED CATEGORY: \(self.tempCategory)")
//        }
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
