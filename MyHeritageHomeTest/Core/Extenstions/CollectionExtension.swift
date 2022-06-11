//
//  CollectionExtension.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 11/06/2022.
//

import Foundation

extension Collection
{
    subscript (safe index: Index) -> Element?
    {
        return indices.contains(index) ? self[index] : nil
    }
}
