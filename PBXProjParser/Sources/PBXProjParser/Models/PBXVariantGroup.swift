//
//  PBXVariantGroup.swift
//  
//
//  Created by Thomas Hedderwick on 31/01/2023.
//

import Foundation

class PBXVariantGroup: PBXObject {
	#if DEBUG
	let children: [String]
	let name: String
	let sourceTree: String

	private enum CodingKeys: String, CodingKey {
		case children
		case name
		case sourceTree
	}
	#endif

	required init(from decoder: Decoder) throws {
		#if DEBUG
		let container = try decoder.container(keyedBy: CodingKeys.self)

		children = try container.decode([String].self, forKey: .children)
		name = try container.decode(String.self, forKey: .name)
		sourceTree = try container.decode(String.self, forKey: .sourceTree)
		#endif

		try super.init(from: decoder)
	}
}
