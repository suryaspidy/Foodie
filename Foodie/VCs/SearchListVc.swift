//
//  SearchListVc.swift
//  Foodie
//
//  Created by surya-zstk231 on 21/09/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchListVc: UIViewController {

    @IBOutlet var historyTableView: UITableView!
    @IBOutlet var searchView: PrimarySearchView!
    
    var placeData: [GMSAutocompletePrediction] = []
    var passed: ((GMSAutocompletePrediction) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.rightAction = {
            print("Right btn tapped")
        }
        searchView.leftAction = {
            self.dismiss(animated: true)
        }
        searchView.updateText = { [weak self] str in
            guard let self = self else {return}
            PlaceManager.getPlaceList(str) { result in
                switch result {
                case .success(let placeData):
                    self.placeData = placeData
                    self.historyTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        searchView.boot(val: .main)
        
        self.historyTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
    }

}
extension SearchListVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.bootCell(name: placeData[indexPath.row].attributedPrimaryText.string, subName: placeData[indexPath.row].attributedSecondaryText?.string ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.passed?(placeData[indexPath.row])
        self.dismiss(animated: true)
    }
}
