//
//  ViewController.swift
//  DarkSkyWeather
//
//  Created by Victor Martin on 5/22/18.
//  Copyright © 2018 Victor Martin. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, UISearchBarDelegate {

    //MARK: - Variables
    
    var viewModel : ViewModel?
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        initialSetUp()
        
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    //MARK: - Setup
    
    func initialSetUp(){
        reloadViewElements(with: "Chicago")
        mySearchBar.text = "Chicago"
    }

    //MARK: - SearchBar Functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        reloadViewElements(with: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Load and set Elements
    
    func reloadViewElements(with city: String){
        SVProgressHUD.show()
        
        viewModel?.loadData(city: city, completion : { (data, err) in
            if err == nil, data != nil{
                self.setViewElements(with: data!, city: city)
            }else{
                self.displayAlert(err: err!)
            }

        })
    }
    
    func displayAlert(err: DarkSkyApiErros){
        
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func setViewElements(with data: BlackSky, city: String){
        DispatchQueue.main.async {
            self.cityName.text = city
            self.weatherIcon.image = data.weatherIcon
            self.tempLbl.text = String(data.weather.temperature)+" F"
            self.windSpeedLbl.text = String(data.weather.windSpeed)
            self.humidLbl.text = String(data.weather.humidity)
            self.summaryLbl.text = data.weather.summary
            
            SVProgressHUD.dismiss()
        }
    }
    
    //MARK: - Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

