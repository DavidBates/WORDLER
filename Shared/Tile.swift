//
//  Tile.swift
//  WORDLER!
//
//  Created by David Bates on 1/29/22.
//

import SwiftUI

struct Tile: View {
    var bgColor:Color = Color("WGreen")
    var letter:String = "W"
    var body: some View {
        let rectSize: CGFloat = 45
        RoundedRectangle(cornerRadius: 5).stroke(bgColor, lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(bgColor))
            .frame(width: rectSize, height: rectSize).overlay(Text(letter).foregroundColor(Color("WText"))).font(Font.custom("ClearSans-Bold", size:36, relativeTo: .title))
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Tile(bgColor: Color("WNot"), letter: "✅")
    }}
