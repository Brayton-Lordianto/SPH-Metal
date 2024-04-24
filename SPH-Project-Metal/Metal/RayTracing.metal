//
//  Metal.metal
//  coding-adventure-sph-try1
//
//  Created by Brayton Lordianto on 3/24/24.
//

#include <metal_stdlib>
using namespace metal;

#include "ParticleMovement.h"

// ray trace the particles
float rayParticle(float3 cam, float3 ray, float3 particle) {
    float radius = 0.01; // placeholder
    
    // by just following the formula
    float3 oc = cam - particle;
    float b = dot(ray, oc);
    float c = dot(oc, oc) - radius * radius;
    float discriminant = b*b - c;
    return discriminant > 0 ? -b - sqrt(discriminant) : -1;
}

[[ stitchable ]] half4 fragshader(float2 pos, half4 sampleColor,
                                  float2 size,
                                  float time, float focalLen,
                                  device const float *particlesRaw, uint numParticlesRaw) {
    // normalize position between 0 and 1
    pos /= size;
    
    // get particle centers
    device float3 *particles = (device float3 *)particlesRaw;
    uint numParticles = numParticlesRaw / 2;
    
    // set background color
    half3 color = half3(1,1,1);
    

        
    // ray for ray tracing
    float3 camera = float3(0,0,-focalLen);
    float3 rayDir = normalize(float3(pos, focalLen));
    
    // for movement
    float3 velocity = float3(0, 0.01, 0);
    
    particles[5].x += 0.0001f;
    particles[10].x += 0.0001f;
    for (uint i = 0; i < 10; i++)
        particles[i] += 0.0001f;
    
    for (uint i = 0; i < numParticles; i++) {
        // perform movement of particles
//        particles[i] = free_fall(particles[i], velocity, time);
//        not sure why even this is glitching out...
//        particles[i].x += 0.0001f;
        
        // ray trace
        float t = rayParticle(camera, rayDir, particles[i]);
        if (t > 0) {
            color = half3(0,0,1); // blue
            break;
        }
    }
    
    
    return half4(sqrt(color), 1);
}

[[ stitchable ]] half4 fragshader2(float2 pos, half4 sampleColor,
                                  float2 size,
                                  float time, float focalLen,
                                  device const float *particlesRaw, uint numParticlesRaw) {
    // normalize position between 0 and 1
    pos /= size;
    
    // get particle centers
    device float3 *particles = (device float3 *)particlesRaw;
    uint numParticles = numParticlesRaw / 2;
    
    // set background color
    half3 color = half3(1,1,1);
    

        
    // ray for ray tracing
    float3 camera = float3(0,0,-focalLen);
    float3 rayDir = normalize(float3(pos, focalLen));
    
    // for movement
    float3 velocity = float3(0, 0.01, 0);
    
    particles[5].x += 0.0001f;
    particles[10].x += 0.0001f;
    for (uint i = 0; i < 10; i++)
        particles[i].x += 1.0f;
    
    for (uint i = 0; i < numParticles; i++) {
        // perform movement of particles
//        particles[i] = free_fall(particles[i], velocity, time);
//        not sure why even this is glitching out...
//        particles[i].x += 0.0001f;
        
        // ray trace
        float t = rayParticle(camera, rayDir, particles[i]);
        if (t > 0) {
            color = half3(0,0,1); // blue
            break;
        }
    }
    
    
    return half4(sqrt(color), 1);
}
