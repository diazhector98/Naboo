//
//  GroupObject.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 06/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class GroupObject: NSObject {

    var sGroupId: String?
    var sGroupName: String?
    var sOwner: String?
    var iGroupIcon: Int?
    
    
    
    init(iGroupIcon: Int, sGroupId: String, sGroupName: String) {
        
        super.init()
        
        self.sGroupId = sGroupId
        self.sGroupName = sGroupName
        self.iGroupIcon = iGroupIcon
        
    }
}
