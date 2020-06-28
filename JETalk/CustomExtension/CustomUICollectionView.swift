//
//  CustomUICollectionView.swift
//  pass_ios
//
//  Created by jinkyu on 31/01/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    fileprivate class SettingBatchContext {
        typealias BlockToExecuteBatch = () -> Void
        var isToExecuteBatch: Bool = false
        var blocksToExecuteBatch: [BlockToExecuteBatch] = []
    }
    fileprivate struct StaticVariable {
        static var settingBatchContextKey = "settingBatchContextKey"
    }
    fileprivate var settingBatchContext: SettingBatchContext {
        if let sbc = objc_getAssociatedObject(self,
                                              &StaticVariables.settingBatchContextKey)
            as? SettingBatchContext {
            return sbc
        }
        else {
            let sbc: SettingBatchContext = SettingBatchContext()
            objc_setAssociatedObject(self,
                                     &StaticVariables.settingBatchContextKey,sbc,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return sbc
        }
    }
    func beginUpdates() {
        settingBatchContext.isToExecuteBatch = true
    }
    func endUpdates() {
        performBatchUpdates({ [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.settingBatchContext.blocksToExecuteBatch
                .forEach({ $0() })
            }, completion: { [weak self] (_) in
                guard let weakSelf = self else { return }
                weakSelf.settingBatchContext.isToExecuteBatch = false
                weakSelf.settingBatchContext.blocksToExecuteBatch.removeAll()
        })
    }
    func reload(itemsAt: [IndexPath]) {
        if settingBatchContext.isToExecuteBatch {
            settingBatchContext.blocksToExecuteBatch.append({ [weak self]
                in
                guard let weakSelf = self else { return }
                weakSelf.reloadItems(at: itemsAt)
            })
        }
        else {
            reloadItems(at: itemsAt)
        }
    }
    func insert(itemsAt: [IndexPath]) {
        if settingBatchContext.isToExecuteBatch {
            settingBatchContext.blocksToExecuteBatch.append({ [weak self]
                in
                guard let weakSelf = self else { return }
                weakSelf.insertItems(at: itemsAt)
            })
        }
        else {
            insertItems(at: itemsAt)
        }
    }
    func delete(itemsAt: [IndexPath]) {
        if settingBatchContext.isToExecuteBatch {
            settingBatchContext.blocksToExecuteBatch.append({ [weak self]
                in
                guard let weakSelf = self else { return }
                weakSelf.deleteItems(at: itemsAt)
            })
        }
        else {
            deleteItems(at: itemsAt)
        }
    }
}
