//
//  CatalogResources.swift
//  Bement
//
//  Created by Runkai Zhang on 9/24/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation

struct Catalog {
    
    public static let links = ["Lexia Reading Core 5": "https://www.lexiacore5.com/?SiteID=3134-9449-4002-2553", "Keyboarding Without Tears": "https://program.kwtears.com", "Think Central": "http://www-k6.thinkcentral.com/ePC/start.do", "InfoBits": "http://libraries.state.ma.us/login?db=ITKE&locid=mlin_w_bement", "DK findout!": "https://www.dkfindout.com/", "Wonderopolis": "https://wonderopolis.org/", "Fact Monster": "https://www.factmonster.com/", "Britannica": "http://libraries.state.ma.us/login?db=eb_es&locid=mlin_w_bement", "CountryReports": "http://www.countryreports.org/", "Code.org": "https://studio.code.org/users/sign_in", "Pebble Go": "https://www.pebblego.com/modules/5/categories/0", "Google": "https://www.google.com/", "MCBA": "http://bementmcba.blogspot.com/", "Gale Database": "http://libraries.state.ma.us/login?db=gale&locid=mlin_w_bement", "NoodleTools": "https://my.noodleTools.com/logon/signin"]
    
    public static let Gradek3 = ["Lexia Reading Core 5", "Keyboarding Without Tears", "Think Central", "InfoBits", "DK findout!", "Wonderopolis", "Fact Monster", "Britannica", "CountryReports", "Code.org", "Pebble Go"]
    public static let Grade45 = ["Lexia Reading Core 5", "Keyboarding Without Tears", "Think Central", "InfoBits", "DK findout!", "Wonderopolis", "Fact Monster", "Britannica", "CountryReports", "Google", "MCBA", "Code.org"]
    public static let Grade6 = ["Gale Databases", "NoodleTools", "Britannica", "CountryReports", "Google", "MCBA", "Code.org"]
    public static let Grade789 = ["Gale Databases", "NoodleTools", "Britannica", "CountryReports", "Google"]
    
    public static let GradeBundle = [Catalog.Gradek3, Catalog.Grade45, Catalog.Grade6, Catalog.Grade789]
}
