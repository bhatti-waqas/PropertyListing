//
//  UITableView+Extension.swift
//  ListingChallenge
//
//  Created by Waqas Naseem on 11/9/21.
//

import UIKit

extension UITableView {
    public func dequeue<T>(for indexPath:IndexPath)->T where T:UITableViewCell{
        return self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
    
    public func register<T>(cell: T.Type) where T:UITableViewCell {
        self.register(T.self, forCellReuseIdentifier: T.cellIdentifier)
    }
}
