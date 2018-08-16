//
//  File1.swift
//  weather
//
//  Created by Александр Харченко on 10.08.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import UIKit

extension CurrentWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast10day.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "day10Cell") as? Forecast10dayCell
        cell?.maxTemp.text = forecast10day[indexPath.row + 1]?.high.celsius
        cell?.minTemp.text = forecast10day[indexPath.row + 1]?.low.celsius
        cell?.dayWeek.text = forecast10day[indexPath.row + 1]?.date.weekday
        cell?.dayImage.downloadImeg(from: (forecast10day[indexPath.row + 1]?.icon_url)!)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
