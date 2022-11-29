//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Nij Mehar on 29/11/22.
//

import SwiftUI

struct TicTacView: View {
    @StateObject private var ticTacViewModel = TicTacViewModel()
    let column:[GridItem] = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())]
    var body: some View {
        GeometryReader{
            geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: column){
                    ForEach(0..<9){i in
                        ZStack{
                            Circle()
                                .foregroundColor(.red)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/3-15,height: geometry.size.height/3-120)
                            Image(systemName: ticTacViewModel.moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40,height: 40)
                        }.onTapGesture{
                            ticTacViewModel.processPlayerMove(for: i)
                        }.alert(item:$ticTacViewModel.alertItem,content: {
                            alertItem in Alert(title: alertItem.title,
                                               message: alertItem.message,
                                               dismissButton: .default(alertItem.buttonTitle,action: {
                                ticTacViewModel.reset()
                                
                            }))
                        })

                    }
                }
                Spacer()
            }.padding(.all,10).disabled(ticTacViewModel.isGameBoardDisabled)
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacView()
    }
}
