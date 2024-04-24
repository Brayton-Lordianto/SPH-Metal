//
//  ParticleMovement.metal
//  SPH-Project-Metal
//
//  Created by Brayton Lordianto on 4/17/24.
//

#include <metal_stdlib>
using namespace metal;

#include "ParticleMovement.h"

half3 myBlue() {
    return half3(1,0,0);
}

float3 free_fall(float3 particlePos, float3 velocity, float dt) {
//    float3 acceleration = float3(0, -gravity, 0); // Gravity acceleration (m/s^2)
//    float3 newVelocity = velocity + acceleration * dt;
//    return particlePos + newVelocity * dt;
    float3 res = particlePos + float3(0.1f,0.0f,0.0f);
    return res;
}
