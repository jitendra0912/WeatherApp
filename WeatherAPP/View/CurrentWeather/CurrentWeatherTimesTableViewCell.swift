//
//  CurrentWeatherTimesTableViewCell.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//
import UIKit

class CurrentWeatherTimesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherList: [List] = [List]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.backgroundColor = .black
        
        self.contentView.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
        setupCollectionView()
        registerNib()
    
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerNib() {
        collectionView.register(TimesCollectionViewCell.self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CurrentWeatherTimesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimesCollectionViewCell.reuseIdentifier, for: indexPath) as? TimesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.config(weather: weatherList[indexPath.row])
        return cell
    }
   
}
