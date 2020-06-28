//
//  CustomDatatype.swift
//  pass_ios
//
//  Created by EOM JUEON on 2020/01/09.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import Foundation
extension Int {
    var withComma: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        
        return decimalFormatter.string(from: self as NSNumber)!
    }
}

extension String{
    var delComma:String{
        if self.count>0{
            return self.replacingOccurrences(of: ",", with: "");
        }
        else{return "0";
        }
    }
}
