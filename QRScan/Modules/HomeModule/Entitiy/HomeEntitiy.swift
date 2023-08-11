//
//  HomeEntitiy.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import Foundation

struct HomeEntity {
    
}

struct HomeProfileCellEntity: Hashable {
    let name: String
    let saldo: String
}

struct HomeMenuEntity: Hashable {
    let id = UUID()
    let identifier: String
    let menuName: String
}

enum HomeSection: CaseIterable {
    case profile
    case menu
}

enum HomeSectionWrapper: Hashable {
    case profile(HomeMenuEntity)
    case menu(HomeProfileCellEntity)
}
