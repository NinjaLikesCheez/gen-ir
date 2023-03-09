//
//  PBXTarget.swift
//  
//
//  Created by Thomas Hedderwick on 31/01/2023.
//

import Foundation

class PBXTarget: PBXObject {
	#if DEBUG
	let buildConfigurationList: String
	let comments: String?
	let productName: String?
	#endif
	let name: String
	let dependencies: [String]

	private enum CodingKeys: String, CodingKey {
		#if DEBUG
		case buildConfigurationList
		case comments
		case productName
		#endif
		case name
		case dependencies

	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		#if DEBUG
		buildConfigurationList = try container.decode(String.self, forKey: .buildConfigurationList)
		comments = try container.decodeIfPresent(String.self, forKey: .comments)
		productName = try container.decodeIfPresent(String.self, forKey: .productName)
		#endif
		name = try container.decode(String.self, forKey: .name)
		dependencies = try container.decode([String].self, forKey: .dependencies)

		try super.init(from: decoder)
	}
}

class PBXAggregateTarget: PBXTarget {
	let buildPhases: [String]

	private enum CodingKeys: String, CodingKey {
		case buildPhases
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		buildPhases = try container.decode([String].self, forKey: .buildPhases)

		try super.init(from: decoder)
	}
}

class PBXLegacyTarget: PBXTarget {}

class PBXNativeTarget: PBXTarget {
	#if DEBUG
	let buildPhases: [String]
	let productInstallPath: String?
	let productType: String
	#endif
	let productReference: String?
	let packageProductDependencies: [String]

	private(set) var targetDependencies: [String: TargetDependency] = [:]

	enum TargetDependency {
		case native(PBXNativeTarget)
		case package(XCSwiftPackageProductDependency)

		var name: String {
			switch self {
			case .native(let target):
				return target.name
			case .package(let package):
				return package.productName
			}
		}
	}

	private enum CodingKeys: String, CodingKey {
		#if DEBUG
		case buildPhases
		case productInstallPath
		case productType
		#endif
		case productReference
		case packageProductDependencies
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		#if DEBUG
		buildPhases = try container.decode([String].self, forKey: .buildPhases)
		productInstallPath = try container.decodeIfPresent(String.self, forKey: .productInstallPath)
		productType = try container.decode(String.self, forKey: .productType)
		#endif
		productReference = try container.decodeIfPresent(String.self, forKey: .productReference)
		packageProductDependencies = try container.decodeIfPresent([String].self, forKey: .packageProductDependencies) ?? []

		try super.init(from: decoder)
	}

	func add(dependency: TargetDependency) {
		targetDependencies[dependency.name] = dependency
	}
}

#if DEBUG
extension PBXNativeTarget: CustomStringConvertible {
	var description: String {
		"""
		<PBXNativeTarget: BuildPhases: \(buildPhases), productInstallPath: \(productInstallPath ?? "nil") \
		productReference: \(productReference ?? "nil"), productType: \(productType), \
		packageProductDependencies: \(packageProductDependencies)>
		"""
	}
}
#endif

class PBXTargetDependency: PBXObject {
	let target: String?
	let targetProxy: String?

	private enum CodingKeys: String, CodingKey {
		case target
		case targetProxy
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		target = try container.decodeIfPresent(String.self, forKey: .target)
		targetProxy = try container.decodeIfPresent(String.self, forKey: .targetProxy)

		try super.init(from: decoder)
	}
}