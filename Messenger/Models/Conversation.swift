//
//  Conversation.swift
//  Messenger
//
//  Created by Leysan Latypova on 09.09.2022.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
