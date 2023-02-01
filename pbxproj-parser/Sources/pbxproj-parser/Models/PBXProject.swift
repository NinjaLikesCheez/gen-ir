//
//  PBXProject.swift
//  
//
//  Created by Thomas Hedderwick on 31/01/2023.
//

import Foundation

class PBXProject: PBXObject {
	let attributes: [String: Any]
	let buildConfigurationList: String
	let compatibilityVersion: String
	let developmentRegion: String
	let hasScannedForEncodings: String
	let knownRegions: [String]
	let mainGroup: String
	let productRefGroup: String
	let projectDirPath: String
	let projectReferences: [[String: [String: String]]]?
	let projectRoot: String
	let targets: [String] /// Hold references to targets via their identifiers

	private enum CodingKeys: String, CodingKey {
		case attributes
		case buildConfigurationList
		case compatibilityVersion
		case developmentRegion
		case hasScannedForEncodings
		case knownRegions
		case mainGroup
		case productRefGroup
		case projectDirPath
		case projectReferences
		case projectRoot
		case targets
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		// We currently don't decode this as it's painful and we don't need it
		attributes = [:]
		buildConfigurationList = try container.decode(String.self, forKey: .buildConfigurationList)
		compatibilityVersion = try container.decode(String.self, forKey: .compatibilityVersion)
		developmentRegion = try container.decode(String.self, forKey: .developmentRegion)
		hasScannedForEncodings = try container.decode(String.self, forKey: .hasScannedForEncodings)
		knownRegions = try container.decode([String].self, forKey: .knownRegions)
		mainGroup = try container.decode(String.self, forKey: .mainGroup)
		productRefGroup = try container.decode(String.self, forKey: .productRefGroup)
		projectDirPath = try container.decode(String.self, forKey: .projectDirPath)
		projectReferences = try container.decodeIfPresent([[String: [String: String]]].self, forKey: .projectReferences)
		projectRoot = try container.decode(String.self, forKey: .projectRoot)
		targets = try container.decode([String].self, forKey: .targets)

		try super.init(from: decoder)
	}
}
