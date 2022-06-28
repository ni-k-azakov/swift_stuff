//
//  WhichWayTests.swift
//  WhichWayTests
//
//  Created by Nikita Kazakov on 09.06.2022.
//

import XCTest
@testable import WhichWay

class WhichWayTests: XCTestCase {

    var taxiApi: TaxiComparatorApi!
    var viewController: ViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        taxiApi = TaxiComparatorApi()
        viewController = ViewController()
    }

    override func tearDownWithError() throws {
        taxiApi = nil
        viewController = nil
        
        try super.tearDownWithError()
    }

    func testGeocode() throws {
        taxiApi.geocode(adress: "Татарский переулок 1, Санкт-Петербург, Россия") { result in
            switch result {
            case .success(let location):
                XCTAssertEqual(location.lat, 59.953217, "Latitude Татарский переулок 1, Санкт-Петербург, Россия")
                XCTAssertEqual(location.lng, 30.305841, "Longitude Татарский переулок 1, Санкт-Петербург, Россия")
            case .failure(let error):
                XCTAssertNoThrow(error)
            }
        }
        taxiApi.geocode(adress: "Проспект сизова 32/1, Санкт-Петербург, Россия") { result in
            switch result {
            case .success(let location):
                XCTAssertEqual(location.lat, 60.01509, "Latitude Проспект сизова 32/1, Санкт-Петербург, Россия")
                XCTAssertEqual(location.lng, 30.276476, "Longitude Проспект сизова 32/1, Санкт-Петербург, Россия")
            case .failure(let error):
                XCTAssertNoThrow(error)
            }
            
        }
        
        taxiApi.getGeocodeFrom(adress: "Татарский переулок 1, Санкт-Петербург, Россия")
        switch taxiApi.locationFrom {
        case .success(let location):
            XCTAssertEqual(location.lat, 59.953217, "Latitude Татарский переулок 1, Санкт-Петербург, Россия")
            XCTAssertEqual(location.lng, 30.305841, "Longitude Татарский переулок 1, Санкт-Петербург, Россия")
        case .failure(let error):
            XCTAssertNoThrow(error)
        }
        taxiApi.getGeocodeTo(adress: "Проспект сизова 32/1, Санкт-Петербург, Россия")
        switch taxiApi.locationTo {
        case .success(let location):
            XCTAssertEqual(location.lat, 60.01509, "Latitude Проспект сизова 32/1, Санкт-Петербург, Россия")
            XCTAssertEqual(location.lng, 30.276476, "Longitude Проспект сизова 32/1, Санкт-Петербург, Россия")
        case .failure(let error):
            XCTAssertNoThrow(error)
        }
    }

    func testWhichTaxiResponse() throws {
        taxiApi.getWhichTaxiResponse(fromLat: 59.953217, fromLng: 30.305841, toLat: 60.01509, toLng: 30.276476) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.seconds, 1653, "WhichTaxi seconds")
                for info in response.costInfo {
                    switch info.key {
                    case "Эконом":
                        XCTAssertEqual(info.value, 378, "WhichTaxi эконом")
                    case "Комфорт":
                        XCTAssertEqual(info.value, 418, "WhichTaxi комфорт")
                    case "СуперКомфорт":
                        XCTAssertEqual(info.value, 488, "WhichTaxi суперКомфорт")
                    case "Бизнес":
                        XCTAssertEqual(info.value, 756, "WhichTaxi бизнес")
                    default:
                        XCTAssertThrowsError(info.key)
                    }
                }
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
    }
    
    func testResponseGetter() throws {
        switch taxiApi.getTaxiResponses(fromAdress: "Татарский переулок 1, Санкт-Петербург, Россия", toAdress: "Проспект сизова 32/1, Санкт-Петербург, Россия") {
        case .success(let info):
            XCTAssertNotNil(info["WhichTaxi"])
            XCTAssertNotNil(info["FairTaxi"])
            XCTAssertNotNil(info["AnotherTaxi"])
        case .failure(let error):
            XCTAssertNoThrow(error)
        }
    }
    
    func testResponseAgregator() throws {
        switch taxiApi.agregateTaxiResponses(from: GeocoderLocation(lat: 59.953217, lng: 30.305841), to: GeocoderLocation(lat: 60.01509, lng: 30.276476)) {
        case .success(let info):
            XCTAssertNotNil(info["WhichTaxi"])
            XCTAssertNotNil(info["FairTaxi"])
            XCTAssertNotNil(info["AnotherTaxi"])
        case .failure(let error):
            XCTAssertNoThrow(error)
        }
    }
    
    func testViewController() throws {
        let textField = UITextField()
        let infoCard = UIView()
        let infoFiller = UIView()
        let errorMessageLabel = UILabel()
        let infoContainer = UIView()
        let loadIndicator = UIActivityIndicatorView()
        let typeLabel = UILabel()
        let routeLineView = RouteLineView()
        let bestTaxiPrice = UILabel()
        let bestTaxiLogo = UIImageView()
        let costRange = UILabel()
        viewController.fromTextField = textField
        viewController.toTextField = textField
        viewController.infoCard = infoCard
        viewController.errorMessageLabel = errorMessageLabel
        viewController.infoContainer = infoContainer
        viewController.loadIndicator = loadIndicator
        viewController.infoFiller = infoFiller
        viewController.typeLabel = typeLabel
        viewController.routeLineView = routeLineView
        viewController.viewDidLoad()
        viewController.findAvailableTaxi(UIButton())
        let horizontalRecognizer = UISwipeGestureRecognizer()
        horizontalRecognizer.direction = .left
        let verticalRecognizer = UISwipeGestureRecognizer()
        verticalRecognizer.direction = .up
        let infoStack = UIStackView()
        let logoStack = UIStackView()
        viewController.infoStack = infoStack
        viewController.logoStack = logoStack
        viewController.bestTaxiPrice = bestTaxiPrice
        viewController.bestTaxiLogo = bestTaxiLogo
        viewController.costRange = costRange
        viewController.HandleCategorySwipe(recognizer: horizontalRecognizer)
        viewController.HandleCategorySwipe(recognizer: verticalRecognizer)
        viewController.handleSwipe(recognizer: horizontalRecognizer)
        viewController.handleSwipe(recognizer: verticalRecognizer)
        XCTAssertTrue(viewController.textFieldShouldReturn(UITextField()))
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
