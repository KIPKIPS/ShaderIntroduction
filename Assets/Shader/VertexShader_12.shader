// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_12"
{
    SubShader
    {
        Pass{
        	Tags { "LightMode"="ForwardBase" }
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "lighting.cginc"
            #pragma vertex Vert
            #pragma fragment Frag  

         
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float4 color:COLOR;
            };
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,v.vertex);
                float3 N=normalize(v.normal);//模型的法向量
                float3 L=normalize(_WorldSpaceLightPos0);

                float NDotL=saturate(dot(N,L));//将顶点指向光源向量和法线向量的点积值限定在0-1之间
                vtf.color=_LightColor0*NDotL;//_lightingColor0是光源的颜色
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color+UNITY_LIGHTMODEL_AMBIENT;//漫反射+环境光
            }
            ENDCG
        }
    }
}
