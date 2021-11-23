//
//  Extensions.swift
//  Iyenga Yoga
//
//  Created by John goodstadt on 16/11/2021.
//

import Foundation

public extension String {

	var nonDiatricic: String {
		let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
		let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
		return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
	}
}
