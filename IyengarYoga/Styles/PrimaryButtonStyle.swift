//
//  ButtonStyle.swift
//  IyengarYoga
//
//  Created by John goodstadt on 18/11/2021.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(5)
			.foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : .blue)
			.overlay(
				RoundedRectangle(cornerRadius: 8)
					.stroke(configuration.isPressed ? Color.white.opacity(0.5) : .blue, lineWidth: 2.0)
			)
	 }
}
