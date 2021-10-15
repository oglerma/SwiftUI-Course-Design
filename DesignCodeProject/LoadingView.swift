//
//  LoadingView.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 10/14/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
		VStack {
			LottieView(filename: "success")
				.frame(width: 200, height: 200)
		}
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
