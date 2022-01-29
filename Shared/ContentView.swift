//
//  ContentView.swift
//  Shared
//
//  Created by David Bates on 1/19/22.
//

import SwiftUI

struct StringList: View {
    var dictionary:[String]
    @State var presentingToast = false
    
    var body: some View {
        List(dictionary, id: \.self) { string in
            Text(string)
        }
    }
}

struct ContentView: View {
    @State var contains: String=""
    @State var excludes: String=""
    @State var dictionary: [String]=LoadDictionary()
    @State private var presentingSheet = false
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            HStack {
                Tile(bgColor: Color("WGreen"), letter: "W")
                Tile(bgColor: Color("WNot"), letter: "O")
                Tile(bgColor: Color("WNot"), letter: "R")
                Tile(bgColor: Color("WNot"), letter: "D")
                Tile(bgColor: Color("WNot"), letter: "L")
                Tile(bgColor: Color("WMaybe"), letter: "E")
                Tile(bgColor: Color("WMaybe"), letter: "R")
            }
            Spacer()
            HStack(){
                Text("Contains: ")
                TextField("", text: $contains).onSubmit({
                    self.dictionary = parseDict(contains: self.contains, excludes: self.excludes)
                })
#if os(iOS)
                    .textInputAutocapitalization(.never).disableAutocorrection(true)
#endif
                    .background(Color.green.opacity(0.2))
            }.padding()
            HStack(){
                Text("Excludes: ")
                TextField("", text: $excludes).onSubmit({
                    self.dictionary = parseDict(contains: self.contains, excludes: self.excludes)
                })
#if os(iOS)
                    .textInputAutocapitalization(.never).disableAutocorrection(true)
#endif
                    .background(Color.red.opacity(0.2))
            }.padding()
            
            Button("Parse"){
                self.dictionary = parseDict(contains: self.contains, excludes: self.excludes)
            }
            StringList(dictionary: dictionary)
        }
    }
    
}

func parseDict(contains:String, excludes:String) -> [String]{
    var dictionary:[String] = LoadDictionary()
    if(contains.count > 0){
        let containSet:CharacterSet = CharacterSet.init(charactersIn: contains)
        
        dictionary = dictionary.filter{
            containSet.isSubset(of: CharacterSet.init(charactersIn: $0))
        }
    }
    if(excludes.count > 0){
        let excludeSet:CharacterSet = CharacterSet.init(charactersIn: excludes)
        
        dictionary = dictionary.filter{
            excludeSet.isDisjoint(with: CharacterSet.init(charactersIn: $0))
        }
    }
    return dictionary
}
// do a filter on dictionaries based on chars as you go. dict1 is first char, 

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    let title: String
    let subtitle: String
    @State var entry:String = ""
    var body: some View {
        VStack(spacing: 20) {
            Text(title).font(.largeTitle)
            Text(subtitle).font(.title).foregroundColor(.gray)
            TextField("text", text: $entry)
            Spacer()
            Button("Dismiss") { self.presentation.wrappedValue.dismiss() }
            .accentColor(.red)
        }.padding(.top)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
