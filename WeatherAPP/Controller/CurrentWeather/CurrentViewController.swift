//
//  CurrentViewController.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {

    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var fadeViewContraint: NSLayoutConstraint!
    var currentWeatherData: WeatherInfo?
    var currentIndex: Int = 0
    var totalPage: Int = 0
    private var fiveDayWeatherData: FiveDayWeather? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var fahrenheitOrCelsius: FahrenheitOrCelsius? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let footerView = UIView()
//        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
//        footerView.backgroundColor = UIColor.lightGray
//        tableView.tableFooterView = footerView
        setupTableView()
        registerNib()
        fetchData()
        fetchFahrenheitOrCelsius()
    }
    
    private func fetchFahrenheitOrCelsius() {
        fahrenheitOrCelsius = UserInfo.getFahrenheitOrCelsius()
    }
    
    private func fetchData() {
        guard let coordinate = currentWeatherData?.coordinate else {
            return
        }
        self.get5DayWeatherByCoordinate(latitude: coordinate.lat,
                                        longitude: coordinate.lon
        )
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerNib() {
        tableView.register(CurrentWeatherTimesTableViewCell.self)
        tableView.register(DaysTableViewCell.self)
        tableView.register(DetailTableViewCell.self)
    }
    
    private func get5DayWeatherByCoordinate(latitude lat: Double, longitude lon: Double) {
        let parameters: [String: Any] = [
            "lat" : "\(lat)",
            "lon" : "\(lon)",
            "appid" : weatherAPIKey
        ]
                
        let request = APIRequest(method: .get,
                                 path: BasePath.current,
                                 queryItems: parameters
        )
        
        APICenter().perform(urlString: BaseURL.weatherURL,
                            request: request
        ) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                if let response = try? response.decode(to: FiveDayWeather.self) {
                    self.fiveDayWeatherData = response.body
                } else {
                    print(APIError.decodingFailed)
                }
            case .failure:
                print(APIError.networkFailed)
            }
        }
    }
    
    @IBAction func listButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func webButtonClicked(_ sender: UIButton) {
        guard let webURL = URL(string: BaseURL.webURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(webURL,
                                      options: [:],
                                      completionHandler: nil
            )
        } else {
            UIApplication.shared.openURL(webURL)
        }
    }
    
    private func updateUI() {
        guard let weather = currentWeatherData,
            let fahrenheitOrCelsius = fahrenheitOrCelsius else {
            return
        }
        
        switch fahrenheitOrCelsius {
        case .Celsius:
            tempLabel.text = (weather.mainValue?.temp.makeCelsius() ?? "") + fahrenheitOrCelsius.emoji
            maxTempLabel.text = weather.mainValue?.tempMax.makeCelsius()
            minTempLabel.text = weather.mainValue?.tempMin.makeCelsius()
        case .Fahrenheit:
            tempLabel.text = (weather.mainValue?.temp.makeFahrenheit() ?? "") + fahrenheitOrCelsius.emoji
            maxTempLabel.text = weather.mainValue?.tempMax.makeFahrenheit()
            minTempLabel.text = weather.mainValue?.tempMin.makeFahrenheit()
        }
        
        cityNameLabel.text = weather.name
        dayLabel.text = calculateDay()
        weatherStatusLabel.text = weather.elements?.first?.description
        if totalPage > 1 {
            pageControl.isHidden = false
            pageControl.numberOfPages = totalPage
            pageControl.currentPage = currentIndex
        }else{
            pageControl.isHidden = true
        }
       
    }
    
    private func calculateDay() -> String {
        guard let timezone = currentWeatherData?.timezone,
            let date = Date().dayNumberOfWeek(time: timezone),
            let day = Week(rawValue: date) else {
            return ""
        }
        return day.StringValue
    }
}

extension CurrentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        
        switch section {
        case 0:
            if let _ = fiveDayWeatherData?.list {
                return 1
            }
        case 1:
            if let list = fiveDayWeatherData?.dailyList {
                return list.count
            }
            
        case 2:
            return 4
            
        default:
            return 0
        }
        
        return 0
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrentWeatherTimesTableViewCell.self), for: indexPath) as! CurrentWeatherTimesTableViewCell
            guard let weatherData = fiveDayWeatherData?.list else {
                return UITableViewCell()
            }
            cell.weatherList = weatherData
        
        return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DaysTableViewCell.self), for: indexPath) as! DaysTableViewCell
            guard let list = fiveDayWeatherData?.dailyList, let fahrenheitOrCelsiusData = fahrenheitOrCelsius else {
                    return UITableViewCell()
            }
            cell.backgroundColor = UIColor.clear
            cell.config(weather:  (list[indexPath.item]),
                   fahrenheitOrCelsius: fahrenheitOrCelsiusData)
        
        return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self), for: indexPath) as! DetailTableViewCell
            guard let weatherData = currentWeatherData else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 0:
                cell.leftTitleLabel.text = "SUNRISE"
                cell.rightTitleLabel.text = "SUNSET"
                cell.rightDescriptionLabel.text = weatherData.sys?.sunrise.dateFromMilliseconds().getCountryTime(byTimeZone: weatherData.sys?.sunrise ?? 0)
                cell.leftDescriptionLabel.text = weatherData.sys?.sunset.dateFromMilliseconds().getCountryTime(byTimeZone: weatherData.sys?.sunset ?? 0)
               
            case 1:
                cell.leftTitleLabel.text = "PRESSURE"
                cell.rightTitleLabel.text = "HUMIDITY"
                cell.rightDescriptionLabel.text =  "\(weatherData.mainValue?.humidity ?? 0) %"
                cell.leftDescriptionLabel.text =  "\(weatherData.mainValue?.pressure ?? 0) hPa"
            case 2:
                cell.leftTitleLabel.text = "VISIBILITY"
                cell.rightTitleLabel.text = "FEELS LIKE"
                cell.leftDescriptionLabel.text =  "\((weatherData.visibility ?? 0)/1000 ) Km"
                cell.rightDescriptionLabel.text =  "\(Int(weatherData.mainValue?.feelsLike ?? 0)) °"
            case 3:
                cell.leftTitleLabel.text = "HIGH TEMP"
                cell.rightTitleLabel.text = "LOW TEM"
                cell.rightDescriptionLabel.text =  "\(Int(weatherData.mainValue?.tempMin ?? 0)) °"
                cell.leftDescriptionLabel.text =  "\(Int(weatherData.mainValue?.tempMax ?? 0)) °"
            default:
                cell.leftTitleLabel.text = ""
                cell.rightTitleLabel.text = ""
                cell.rightDescriptionLabel.text =  ""
                cell.leftDescriptionLabel.text =  ""
            }
            
            return cell
        
        default:
            return UITableViewCell()
        }

        
        
    }

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 40
        case 2:
            return 60
        default:
            return 0
        }
        
    }
    
}


