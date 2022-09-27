//
//  LearningShaders.metal
//  LearningMetal
//
//  Created by Nikita Kazakov on 26.09.2022.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    simd_float3 position [[ attribute(0) ]];
    simd_float4 color [[attribute(1) ]];
};

struct RasterizerData {
    simd_float4 position [[ position  ]];
    simd_float4 color;
};

vertex RasterizerData basic_vertex_shader(const VertexIn vertexIn  [[ stage_in  ]]) {
    RasterizerData rast_data;
    rast_data.position = float4(vertexIn.position, 1);
    rast_data.color = vertexIn  .color;
    return rast_data;
}

fragment half4 basic_fragment_shader(RasterizerData rast_data [[ stage_in ]]) {
    simd_float4 color = rast_data.color;
    float center_relation = 1;
//    center_relation *= 1 - abs(color.r - 0.33);
//    center_relation *= 1 - abs(color.g - 0.33);
//    center_relation *= 1 - abs(color.b - 0.33);
//    return half4(color.r + center_relation, color.g + center_relation, color.b + center_relation, color.a);
    return half4(color.r, color.g, color.b, color.a);
}


