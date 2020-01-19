// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_12"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
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
                float3 L=Worlds

                vtf.color=float4 (0,1,1,1);
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color;
            }
            ENDCG
        }
    }
}
