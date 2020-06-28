//
//  CustomSlider.swift
//  test_1130
//
//  Created by EOM JUEON on 2019/12/06.
//  Copyright © 2019 EOM JUEON. All rights reserved.
//

import UIKit

extension UISlider{

    @IBInspectable
    var twoThumb:Bool{
        get{
            return layer.cornerRadius;
        }
        set{
             layer.cornerRadius=newValue;
        }
    }
}
