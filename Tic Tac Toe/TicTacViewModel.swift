//
//  viewModel.swift
//  Tic Tac Toe
//
//  Created by Nij Mehar on 29/11/22.
//

import SwiftUI

class TicTacViewModel:ObservableObject{
    
    @Published  var moves:[Move?] = Array(repeating: nil, count: 9)
    @Published  var isGameBoardDisabled = false
    @Published  var alertItem:AlertItem?
    
    
    func draw(for player:Player,in moves:[Move?])->Bool{
        return moves.compactMap{$0}.count == 9
    }
    
    func processPlayerMove(for i:Int){
        if isSquareOccupied(in: moves, forIndex: i) {return}
        
        moves[i] = Move(player: .human, boardIndex: i)
       
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = Alertcontext.humanWin
            print("human wins")
            return
        }
        
        if draw(for: .human, in: moves) {alertItem = Alertcontext.draw
            
            print("draw1")
            return
        }
        isGameBoardDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            let computerPosition = self.determineComputerMovePosition(for:.computer,in: self.moves)
            self.moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            self.isGameBoardDisabled = false
            if self.checkWinCondition(for: .computer, in: self.moves) {
                print("computer wins")
                self.alertItem = Alertcontext.computerWin
                return
            }
         
            if  self.draw(for: .human, in: self.moves) {self.alertItem = Alertcontext.draw
                print("draw2")
                return
            }
        })
       
    }
    
    
    func determineComputerMovePosition(for player:Player ,in moves:[Move?])->Int {
        
        let winPatterns:Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let computerMoves = moves.compactMap{$0}.filter{$0.player == player}
        let computerPositions = Set(computerMoves.map{$0.boardIndex})
        
        for pattern in winPatterns{
            let winPosition = pattern.subtracting(computerPositions)
            if winPosition.count == 1
            {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable{
                    return winPosition.first!
                }

            }
        }
        let playerMoves = moves.compactMap{$0}.filter{$0.player == .human}
        let playerPosition = Set(playerMoves.map{$0.boardIndex})
        
        for pattern in winPatterns{
            let winPosition = pattern.subtracting(playerPosition)
            if winPosition.count == 1
            {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable{
                    return winPosition.first!
                }

            }
        }
        
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {return centerSquare}
            
        var movePosition = Int.random(in: 0..<9)
        while(isSquareOccupied(in: moves, forIndex: movePosition)){
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    
    func checkWinCondition(for player:Player,in moves:[Move?])->Bool{
        let winPatterns:Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let playerMoves = moves.compactMap{$0}.filter{$0.player == player}
        let playerPosition = Set(playerMoves.map{$0.boardIndex})
        
        for i in winPatterns where i.isSubset(of: playerPosition){
            print(playerPosition)
            return true}
        return false
    }
    
    
    func isSquareOccupied(in moves:[Move?],forIndex index:Int)->Bool{
        return moves.contains(where: {$0?.boardIndex == index})
    }

    struct Move{
        let player:Player
        let boardIndex:Int
        var indicator:String{
            return player == .human ? "xmark" : "circle"
        }
        
    }


    enum Player {
        case human
        case computer
    }
    func reset(){
        moves = Array.init(repeating: nil, count: 9)

        isGameBoardDisabled = false
    }
}
