//
//  Organization.swift
//  Instagrid
//
//  Created by Djiva Canessane on 27/03/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

class GridLayout {
    
    var photoCountTopRow: Int
    var photoCountBottomRow: Int
    var isFilled: Bool = false
    
    init(photoCountTopRow: Int, photoCountBottomRow: Int) {
        self.photoCountTopRow = photoCountTopRow
        self.photoCountBottomRow = photoCountBottomRow
    }
      
}
