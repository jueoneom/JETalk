//
//  CustomUIScrollView.swift
//  pass_ios
//
//  Created by jinkyu on 13/03/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit

extension UIScrollView {

    func scrollToTop() {
            let topOffset = CGPoint(x: 0, y: -contentInset.top)
            setContentOffset(topOffset, animated: true)
    }

}
