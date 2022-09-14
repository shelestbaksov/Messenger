//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Leysan Latypova on 14.09.2022.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModeltype: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
