//
//  GlobalVariable.swift
//  Bement
//
//  Created by Runkai Zhang on 8/19/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation

/// The global state machine, avoid its usage in the future.
struct GlobalVariable {
    /// A integer to store row data for the library catalog page.
    public static var row = Int()
    /// Check which grade the catalog is in. Try reimplementing this with 2D array or something in the future.
    public static var CatalogGrade = String()
}
