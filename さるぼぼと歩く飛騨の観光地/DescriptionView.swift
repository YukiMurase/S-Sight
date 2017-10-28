//
//  DescriptionView.swift
//  さるぼぼと歩く飛騨の観光地
//
//  Created by timecapsule04 on 2017/10/28.
//  Copyright © 2017年 mc-mac14. All rights reserved.
//

import Foundation
import UIKit

class DescriptionView: UIView{
    @IBOutlet weak var baseView: UIView!
    
    @IBAction func close(_ sender:UIButton) {
        self.removeFromSuperview()
        
    }
    
}
