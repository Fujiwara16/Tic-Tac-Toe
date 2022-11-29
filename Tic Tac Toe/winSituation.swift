//
//  winSituation.swift
//  Tic Tac Toe
//
//  Created by Nij Mehar on 29/11/22.
//

import SwiftUI

struct AlertItem:Identifiable{
    var id = UUID()
    var title:Text
    var message: Text
    var buttonTitle:Text
}

enum Alertcontext {
    static let humanWin = AlertItem(title: Text("You Win!"), message: Text("You are so smart"), buttonTitle: Text("Hell Yeah!"))
    static let computerWin = AlertItem(title: Text("Computer Wins!"), message: Text("Better luck next time"), buttonTitle: Text("Try Again"))
    static let draw = AlertItem(title: Text("Draw!"), message: Text("It's a Draw"), buttonTitle: Text("Try Again"))
}
