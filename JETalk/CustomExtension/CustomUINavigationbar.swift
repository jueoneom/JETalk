//
//  CustomUINavigationbar.swift
//  pass_ios
//
//  Created by EOM JUEON on 2019/12/29.
//  Copyright © 2019 EOM JUEON. All rights reserved.
//

import UIKit

extension UINavigationBar{
    
    @IBInspectable
    var removeShadow:Bool{
        get{
            return true;
        }
        set{
            if newValue{
                self.setBackgroundImage(UIImage(), for: .default);
                self.shadowImage=UIImage();
            }
        }
    }
}
