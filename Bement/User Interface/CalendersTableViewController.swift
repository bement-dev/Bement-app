//
//  CalendersTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/24/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class CalendersTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 23
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
                super.traitCollectionDidChange(previousTraitCollection)

                let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
                
                if userInterfaceStyle == .dark {
                    self.view.backgroundColor = .black
                } else {
                    self.view.backgroundColor = .white
                }
            }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/cf_calendar/feed.cfm?type=ical&feedID=0FCF7BB9B0D84E9DADFCEBB3AF6ED50E")!, options: [:], completionHandler: nil)
            case 1:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/calendar_348.ics")!, options: [:], completionHandler: nil)
            case 2:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/calendar_349.ics")!, options: [:], completionHandler: nil)
            case 3:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/calendar_354.ics")!, options: [:], completionHandler: nil)
            case 4:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/calendar_351.ics")!, options: [:], completionHandler: nil)
            case 5:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/calendar_355.ics")!, options: [:], completionHandler: nil)
            default:
                print("Something when wrong!")
            }
        } else {
            switch indexPath.row {
            case 0:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/cf_calendar/feed.cfm?type=ical&feedID=51D62D835C4D48C3BFA41736E4E69818")!, options: [:], completionHandler: nil)
            case 1:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_129.ics")!, options: [:], completionHandler: nil)
            case 2:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_128.ics")!, options: [:], completionHandler: nil)
            case 3:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_116.ics")!, options: [:], completionHandler: nil)
            case 4:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_122.ics")!, options: [:], completionHandler: nil)
            case 5:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_120.ics")!, options: [:], completionHandler: nil)
            case 6:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_125.ics")!, options: [:], completionHandler: nil)
            case 7:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_135.ics")!, options: [:], completionHandler: nil)
            case 8:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_131.ics")!, options: [:], completionHandler: nil)
            case 9:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_111.ics")!, options: [:], completionHandler: nil)
            case 10:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_112.ics")!, options: [:], completionHandler: nil)
            case 11:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_127.ics")!, options: [:], completionHandler: nil)
            case 12:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_130.ics")!, options: [:], completionHandler: nil)
            case 13:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_123.ics")!, options: [:], completionHandler: nil)
            case 14:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_124.ics")!, options: [:], completionHandler: nil)
            case 15:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_121.ics")!, options: [:], completionHandler: nil)
            case 16:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_115.ics")!, options: [:], completionHandler: nil)
            case 17:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_126.ics")!, options: [:], completionHandler: nil)
            case 18:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_113.ics")!, options: [:], completionHandler: nil)
            case 19:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_133.ics")!, options: [:], completionHandler: nil)
            case 20:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_119.ics")!, options: [:], completionHandler: nil)
            case 21:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_132.ics")!, options: [:], completionHandler: nil)
            case 22:
                UIApplication.shared.open(URL(string: "webcal://www.bement.org/calendar/team_114.ics")!, options: [:], completionHandler: nil)
            default:
                print("Something when wrong!")
            }
        }
    }
}
