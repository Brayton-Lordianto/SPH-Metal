//
//  ContentView.swift
//  coding-adventure-sph-try1
//
//  Created by Brayton Lordianto on 3/22/24.
//

import SwiftUI

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
//var particlePositions = (0..<250).map { _ in
//    SIMD3<Float>(
//        Float.random(in: 0.1...0.9),
//        Float.random(in: 0.1...0.9),
//        -0.1
//    )
//}.uniqued()
var particlePositions = sampleParticlePositions // comment this and uncomment above if you want an RNG

struct ContentView: View {
    @State private var startTime = Date.now
    @State private var focal = 3.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let time = Float(timeline.date.timeIntervalSince(startTime))
            
            Rectangle()
                .frame(width: 500, height: 500)
                .colorEffect(ShaderLibrary.fragshader(
                    .float2(.init(width: 500, height: 500)),
                    .float(time), .float(focal),
                    .floatArray(particlePositions.flatMap({
                        [$0.x, $0.y, $0.z]
                    }))
                ))
//                .visualEffect { content, geometryProxy in
//                    // 500 by 500 = geometryproxy.size
//                    print(time)
//                    return
//                    content
////                        .colorEffect(ShaderLibrary.fragshader(
////                            .float2(geometryProxy.size),
////                            .float(time), .float(focal),
////                            .floatArray(particlePositions.flatMap({
////                                [$0.x, $0.y, $0.z]
////                            }))
////                        ))
//                }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
