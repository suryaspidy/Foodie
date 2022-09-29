//
//  SearchVc.swift
//  Foodie
//
//  Created by surya-zstk231 on 15/09/22.
//

import UIKit

class SearchVc: UIViewController {

    @IBOutlet var endLocationTextFeils: UITextField!
    @IBOutlet var searchHistoryTableView: UITableView!
    @IBOutlet var startLocationTextField: UITextField!
    @IBOutlet var backBtn: UIButton!
    
    var data = ["A","B","C","D"]
    
    var historyList = [["A","B","C","D"],["A","B","C","D"],["A","B","C","D"],["A","B","C","D"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchHistoryTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        self.searchHistoryTableView.dataSource = self
        self.searchHistoryTableView.delegate = self
    }
    
    func bootVc(destination: String?) {
        self.endLocationTextFeils.text = destination
    }
    

    @IBAction func locationToggleBtn(_ sender: Any) {
        let startLocation = self.startLocationTextField.text
        let endLocation = self.endLocationTextFeils.text
        
        self.startLocationTextField.text = endLocation
        self.endLocationTextFeils.text = startLocation
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


extension SearchVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyList[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.updateValue(frmoLocationName: historyList[indexPath.section][indexPath.row], frmoSubLocationName: historyList[indexPath.section][indexPath.row],toLocationName: historyList[indexPath.section][indexPath.row], toSubLocationName: historyList[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        data[section]
    }
    
}
