//
//  ContentView.swift
//  Shared
//
//  Created by David Bates on 1/19/22.
//

import SwiftUI
import ToastUI

struct StringList: View {
    var dictionary:[String]
    @State var presentingToast = false
    
    var body: some View {
        List(dictionary, id: \.self) { string in
            Text(string).onTapGesture(count: 2) {
                UIPasteboard.general.string = string
                self.presentingToast = true
                
            }
        }.toast(isPresented: $presentingToast, dismissAfter: 1) {
            ToastView("Copied!") {
              // custom content views
              Image(systemName: "arrow.up.doc.on.clipboard")
                .font(.system(size: 48))
                .foregroundColor(.green)
                .padding()
            } background: {
              // custom background views
              Color.green.opacity(0.01)
            }
          }
    }
}

struct ContentView: View {
    @State var contains: String=""
    @State var excludes: String=""
    @State var dictionary: [String]=LoadDictionary()
    var body: some View {
        VStack(alignment: .center){
            Text("WORDLER").font(.largeTitle).fontWeight(.bold).foregroundColor(.green)
            HStack(){
                Text("Contains: ")
                TextField("", text: $contains).textInputAutocapitalization(.never).disableAutocorrection(true).background(Color.green.opacity(0.2))
            }.padding()
            HStack(){
                Text("Excludes: ")
                TextField("", text: $excludes).textInputAutocapitalization(.never).disableAutocorrection(true).background(Color.red.opacity(0.2))
            }.padding()
            Button("Parse"){
                self.dictionary = LoadDictionary()
                if(self.contains.count > 0){
                    let containSet:CharacterSet = CharacterSet.init(charactersIn: self.contains)
                    
                    self.dictionary = self.dictionary.filter{
                        containSet.isSubset(of: CharacterSet.init(charactersIn: $0))
                    }
                }
                if(self.excludes.count > 0){
                    let excludeSet:CharacterSet = CharacterSet.init(charactersIn: self.excludes)
                    
                    self.dictionary = self.dictionary.filter{
                        excludeSet.isDisjoint(with: CharacterSet.init(charactersIn: $0))
                    }
                }
                
            }
            StringList(dictionary: dictionary)
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
