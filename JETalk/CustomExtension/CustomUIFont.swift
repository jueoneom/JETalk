//
//  CustomUIFont.swift
//  pass_ios
//
//  Created by jinkyu on 13/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import Foundation
import UIKit

extension UIFontDescriptor.AttributeName{
    static let nsctFontUIUsage=UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute");
}

struct Resources{
    struct Fonts{
        
    }
}

extension Resources.Fonts{
    enum weight:String{
        case light="Montserrat-Light"
        case regular="Montserrat-Black"
        case bold="Montserrat-Bold"
    }
}

extension UIFont{
    @objc class func mySystemFont(ofSize:CGFloat, weight:UIFont.Weight)->UIFont{
        switch weight{
        case .semibold, .bold, .heavy:
            return UIFont(name:Resources.Fonts.weight.bold.rawValue, size:ofSize)!;
        case .black:
            return UIFont(name:Resources.Fonts.weight.regular.rawValue, size:ofSize)!;
        default:
            return UIFont(name:Resources.Fonts.weight.light.rawValue, size:ofSize)!;
            
        }
    }
    
     
}
