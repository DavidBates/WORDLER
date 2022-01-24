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
    @State private var presentingSheet = false
    var body: some View {
        VStack(alignment: .center){
            HStack {
                let rectSize: CGFloat = 45
                RoundedRectangle(cornerRadius: 5).stroke(Color("WGreen"), lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(Color("WGreen")))
                        .frame(width: rectSize, height: rectSize).overlay(Text("W").foregroundColor(Color("WText")))
                RoundedRectangle(cornerRadius: 5).stroke(Color("WNot"), lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(Color("WNot")))
                        .frame(width: rectSize, height: rectSize).overlay(Text("O").foregroundColor(Color("WText")))
                RoundedRectangle(cornerRadius: 5).stroke(Color("WNot"), lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(Color("WNot")))
                        .frame(width: rectSize, height: rectSize).overlay(Text("R").foregroundColor(Color("WText")))
                RoundedRectangle(cornerRadius: 5).stroke(Color("WNot"), lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(Color("WNot")))
                        .frame(width: rectSize, height: rectSize).overlay(Text("D").foregroundColor(Color("WText")))
                RoundedRectangle(cornerRadius: 5).stroke(Color("WNot"), lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(Color("WNot")))
                        .frame(width: rectSize, height: rectSize).overlay(Text("L").foregroundColor(Color("WText")))
                RoundedRectangle(cornerRadius: 5).stroke(Color("WMaybe"), lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(Color("WMaybe")))
                        .frame(width: rectSize, height: rectSize).overlay(Text("E").foregroundColor(Color("WText")))
                RoundedRectangle(cornerRadius: 5).stroke(Color("WMaybe"), lineWidth: 3).background(RoundedRectangle(cornerRadius: 5).fill(Color("WMaybe")))
                        .frame(width: rectSize, height: rectSize).overlay(Text("R").foregroundColor(Color("WText")))
            }
            .font(Font.custom("ClearSans-Bold", size:36, relativeTo: .title))
            Spacer()
            HStack(){
                Text("Contains: ")
                TextField("", text: $contains).textInputAutocapitalization(.never).disableAutocorrection(true).background(Color.green.opacity(0.2))
            }.padding()
            HStack(){
                Text("Excludes: ")
                TextField("", text: $excludes).textInputAutocapitalization(.never).disableAutocorrection(true).background(Color.red.opacity(0.2))
            }.padding()
//            HStack(){
//                Button("B") {
//                            // 2. Trigger presenting the sheet
//                            self.presentingSheet = true
//                }.popover(isPresented: $presentingSheet, arrowEdge: .top) {
//                    ModalView(title: "First Letter",
//                              subtitle: "Pick the first letter")
//
//                }
//
//                Button(action:{
//
//                }){
//                    Text("R ").foregroundColor(.white)
//
//                }.buttonStyle(.borderedProminent).buttonBorderShape(.roundedRectangle(radius: 5)).foregroundColor(.gray).padding()
//                Button(action:{
//
//                }){
//                    Text("E ").foregroundColor(.white)
//
//                }.buttonStyle(.bordered).buttonBorderShape(.roundedRectangle(radius: 5)).padding()
//                Button(action:{
//
//                }){
//                    Text("A ").foregroundColor(.white)
//
//                }.buttonStyle(.bordered).buttonBorderShape(.roundedRectangle(radius: 5)).padding()
//                Button(action:{
//
//                }){
//                    Text("D ").foregroundColor(.white)
//
//                }.buttonStyle(.borderedProminent).buttonBorderShape(.roundedRectangle(radius: 5)).foregroundColor(.gray).padding()
//            }
            
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
        ContentView()
    }
}
