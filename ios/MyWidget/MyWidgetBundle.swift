//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by Tornike Gogberashvili on 25.02.25.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetControl()
        MyWidgetLiveActivity()
    }
}
