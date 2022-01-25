//
//  DictionaryLoader.swift
//  WORDLER
//
//  Created by David Bates on 1/25/22.
//

import Foundation

func LoadDictionary(dict:String = "") -> [String]{
    switch(dict){
    case "Scrabble":
        return LoadScrabbleDictionary()
    default:
        return LoadWordleDictionary()
    }
}
