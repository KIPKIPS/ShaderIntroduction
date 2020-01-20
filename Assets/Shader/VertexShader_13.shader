﻿// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_13"
{
    SubShader
    {
        Pass{
        	Tags { "LightMode"="ForwardBase" }//光照模式
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "lighting.cginc"
            #pragma vertex Vert
            #pragma fragment Frag  

         
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float4 color:COLOR;
                float3 normal:NORMAL;
            };
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,v.vertex);
                vtf.normal=v.normal;
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                float3 N=normalize(vtf.normal);//模型的法向量
                float3 L=normalize(_WorldSpaceLightPos0);
                N=normalize(mul(float4(N,0),unity_WorldToObject).xyz);

                float NDotL=saturate(dot(N,L));//将顶点指向光源向量和法线向量的点积值限定在0-1之间
                vtf.color=_LightColor0*NDotL;//_lightingColor0是光源的颜色
                return vtf.color+UNITY_LIGHTMODEL_AMBIENT;//漫反射+环境光
            }
            ENDCG
        }
    }
}
