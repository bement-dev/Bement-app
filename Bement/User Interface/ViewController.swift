//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import CloudKit
import FeedKit
import SwiftyJSON

class ViewController: UIViewController {
    
    private var observer: NSObjectProtocol?
    
    public static var twitterRetrieved = false
    public static var facebookRecieved = false
    
    var originalLocation: CGFloat?
    var originalLocationMoved: CGFloat?
    
    @IBOutlet var socialButton: UIButton!
    @IBOutlet var calendersButton: UIButton!
    @IBOutlet var lunchButton: UIButton!
    @IBOutlet var reportsButton: UIButton!
    @IBOutlet var supportButton: UIButton!
    @IBOutlet var hourTitle: UILabel!
    @IBOutlet var startHour: UILabel!
    @IBOutlet var endHour: UILabel!
    @IBOutlet var data: UIButton!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var uvBackground: UIView!
    @IBOutlet var uvLabel: UILabel!
    
    var button: HamburgerButton! = nil
    @IBOutlet var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        Tools.beautifulButton(supportButton)
        Tools.beautifulButton(reportsButton)
        Tools.beautifulButton(lunchButton)
        Tools.beautifulButton(calendersButton)
        Tools.beautifulButton(socialButton)
        
        uvBackground.layer.cornerRadius = 5
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
            self.fetchData()
            self.fetchPosts()
        }
        
        originalLocationMoved = data.center.x
        originalLocation = data.center.x - view.bounds.width
        
        button = HamburgerButton(frame: CGRect(x: 0, y: 0, width: 54, height: 54))
        button.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
        
        buttonView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: buttonView.topAnchor),
            button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            button.leftAnchor.constraint(equalTo: buttonView.leftAnchor),
            button.rightAnchor.constraint(equalTo: buttonView.rightAnchor),
            button.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
        ])
    }
    
    public static var hasMessages = false
    
    func fetchData() {
        
        retrieveWeatherData()
        
        let publicDatabase = CKContainer.default().publicCloudDatabase
        let recordID = CKRecord.ID(recordName: "0")
        publicDatabase.fetch(withRecordID: recordID, completionHandler: { record, error in
            if error != nil {
                DispatchQueue.main.sync {
                    self.hourTitle.text = "There are no special"
                    self.startHour.text = "announcements at this moment."
                    self.endHour.text = ""
                }
                
                ViewController.hasMessages = false
            } else {
                if Bool(truncating: (record!["display"] as! Int) as NSNumber) == true {
                    DispatchQueue.main.sync {
                        self.hourTitle.text = record!["titleString"]
                        self.startHour.text = record?["firstLine"] ?? ""
                        self.endHour.text = record?["secondLine"] ?? ""
                    }
                    
                    ViewController.hasMessages = true
                } else {
                    DispatchQueue.main.sync {
                        self.hourTitle.text = "There are no special"
                        self.startHour.text = "announcements at this moment."
                        self.endHour.text = ""
                    }
                    
                    ViewController.hasMessages = false
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
        adjustMenuItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
        adjustMenuItem()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        adjustMenuItem()
    }
    
    func fetchPosts() {
        AppDelegate.facebookItems.removeAll()
        AppDelegate.twitterItems.removeAll()
        
        let twitterURL = URL(string: "https://rss.app/feeds/U5sBo6uPH2lPhQTq.xml")!
        let twitterParser = FeedParser(URL: twitterURL)
        twitterParser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            if result.isSuccess {
                for item in result.rssFeed!.items! {
                    AppDelegate.twitterItems.append(item)
                }
                ViewController.twitterRetrieved = true
            } else {
                ViewController.twitterRetrieved = false
                print(result.error!)
            }
        }
        
        let facebookURL = URL(string: "https://rss.app/feeds/q0MUQ8lpZOqiLsHx.xml")!
        let facebookParser = FeedParser(URL: facebookURL)
        facebookParser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            if result.isSuccess {
                for item in result.rssFeed!.items! {
                    AppDelegate.facebookItems.append(item)
                }
                ViewController.facebookRecieved = true
            } else {
                ViewController.facebookRecieved = false
                print(result.error!)
            }
        }
    }
    
    @objc func toggle(_ sender: AnyObject!) {
        
        adjustMenuItem()
        button.showsMenu = !button.showsMenu
        
        if button.showsMenu {
            UIView.animate(withDuration: 0.3) {
                self.data.center.x += self.view.bounds.width
                self.data.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.data.center.x -= self.view.bounds.width
                self.data.alpha = 0
            }
        }
    }
    
    @IBAction func backToMain(segue: UIStoryboardSegue) {
        fetchData()
        adjustMenuItem()
        
        UIView.animate(withDuration: 0.4) {
            self.socialButton.transform = CGAffineTransform.identity
            self.calendersButton.transform = CGAffineTransform.identity
            self.lunchButton.transform = CGAffineTransform.identity
            self.reportsButton.transform = CGAffineTransform.identity
            self.supportButton.transform = CGAffineTransform.identity
        }
    }
    
    func adjustMenuItem() {
        //print("Adjusted")
        if button.showsMenu {
            self.data.center.x = originalLocationMoved!
            self.data.alpha = 1
        } else {
            self.data.center.x = originalLocation!
            self.data.alpha = 0
        }
    }
    
    @IBAction func touchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
        completion: { _ in  })
    }
    
    @IBAction func touchExit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func instagramPressed(_ sender: Any) {
        if ViewController.facebookRecieved && ViewController.twitterRetrieved {
            self.performSegue(withIdentifier: "social", sender: self)
        } else {
            let alert = UIAlertController(title: "Please wait", message: "The social media data are still being retrieved.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: .none)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func retrieveWeatherData() {
        let apiKey = URL(string: "https://api.darksky.net/forecast/149da9678f344c568394d88cf55289f2/42.5482866,-72.6059389")
        var weather: WeatherStore = WeatherStore()
        
        if let url = apiKey {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print(error)
                } else {
                    if let usableData = data {
                        weather = WeatherStore(usableData)
                        DispatchQueue.main.sync {
                            self.temperatureLabel.text = "\(weather.fahrenheit)/\(weather.celsius)°"
                            self.uvLabel.text = "UV \(weather.uvIndex)"
                            switch weather.uvIndex {
                            case 0: self.uvBackground.backgroundColor = UIColor.systemGreen
                            case 1: self.uvBackground.backgroundColor = UIColor.systemGreen
                            case 2: self.uvBackground.backgroundColor = UIColor.systemGreen
                            case 3: self.uvBackground.backgroundColor = UIColor.systemYellow
                            case 4: self.uvBackground.backgroundColor = UIColor.systemYellow
                            case 5: self.uvBackground.backgroundColor = UIColor.systemYellow
                            case 6: self.uvBackground.backgroundColor = UIColor.systemOrange
                            case 7: self.uvBackground.backgroundColor = UIColor.systemOrange
                            case 8: self.uvBackground.backgroundColor = UIColor.systemRed
                            case 9: self.uvBackground.backgroundColor = UIColor.systemRed
                            case 10: self.uvBackground.backgroundColor = UIColor.systemRed
                            case 11: self.uvBackground.backgroundColor = UIColor.systemPurple
                            case 12: self.uvBackground.backgroundColor = UIColor.systemPurple
                            default: self.uvBackground.backgroundColor = UIColor.systemPurple
                            }
                            
                            //print(self.weather!.icon)
                            switch weather.icon {
                            case "clear-day":
                                self.weatherIcon.image = UIImage(systemName: "sun.max.fill")
                                self.weatherIcon.tintColor = UIColor.systemYellow
                            case "clear-night":
                                self.weatherIcon.image = UIImage(systemName: "moon.fill")
                                self.weatherIcon.tintColor = UIColor.systemYellow
                            case "rain":
                                self.weatherIcon.image = UIImage(systemName: "cloud.rain.fill")
                                self.weatherIcon.tintColor = UIColor.systemTeal
                            case "snow":
                                self.weatherIcon.image = UIImage(systemName: "snow")
                                self.weatherIcon.tintColor = UIColor.systemTeal
                            case "sleet":
                                self.weatherIcon.image = UIImage(systemName: "cloud.sleet.fill")
                                self.weatherIcon.tintColor = UIColor.systemTeal
                            case "wind":
                                self.weatherIcon.image = UIImage(systemName: "wind")
                                self.weatherIcon.tintColor = UIColor.systemTeal
                            case "fog":
                                self.weatherIcon.image = UIImage(systemName: "cloud.fog.fill")
                                self.weatherIcon.tintColor = UIColor.systemGray
                            case "cloudy":
                                self.weatherIcon.image = UIImage(systemName: "cloud.fill")
                                self.weatherIcon.tintColor = UIColor.systemGray
                            case "partly-cloudy-day":
                                self.weatherIcon.image = UIImage(systemName: "cloud.sun.fill")
                                self.weatherIcon.tintColor = UIColor.systemYellow
                            case "partly-cloudy-night":
                                self.weatherIcon.image = UIImage(systemName: "cloud.moon.fill")
                                self.weatherIcon.tintColor = UIColor.systemBlue
                            case "hail":
                                self.weatherIcon.image = UIImage(systemName: "cloud.hail.fill")
                                self.weatherIcon.tintColor = UIColor.systemBlue
                            case "thunderstorm":
                                self.weatherIcon.image = UIImage(systemName: "cloud.bolt.rain.fill")
                                self.weatherIcon.tintColor = UIColor.systemYellow
                            case "tornado":
                                self.weatherIcon.image = UIImage(systemName: "tornado")
                                self.weatherIcon.tintColor = UIColor.systemBlue
                            default: print("This should not happen!")
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    @IBAction func darksky(_ sender: Any) {
        guard let url = URL(string: "https://darksky.net/poweredby/") else { return }
        UIApplication.shared.open(url)
    }
}
