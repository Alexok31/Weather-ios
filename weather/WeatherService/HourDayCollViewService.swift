//
//  HourDayCollViewService.swift
//  weather
//
//  Created by Александр Харченко on 10.08.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import UIKit

extension CurrentWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourDayArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell", for: indexPath) as! HourDayCell
        cell.tempLabel.text = "\((hourDayArray[indexPath.row]?.temp.metric)!)°"
        cell.timeLabel.text = "\((hourDayArray[indexPath.row]?.FCTTIME.hour_padded)!)"
        cell.imageWeather.downloadImeg(from: (hourDayArray[indexPath.row]?.icon_url)!)
        cell.blur.layer.cornerRadius = 15
        
        return cell
    }
    
    
}
