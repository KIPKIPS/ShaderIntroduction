// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shader/VertexShader_06"
{

    SubShader
    {
        Pass{
            CGPROGRAM
            #include "unitycg.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            uniform float4x4 mvp;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
            };
            
            VertToFrag Vert(appdata_base adb){
                VertToFrag vtf;
                //vtf.pos=mul(UNITY_MATRIX_MVP,adb.vertex)
                //vtf.pos=UnityObjectToClipPos(adb.vertex );
                vtf.pos=mul(mvp,adb.vertex );
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return float4(1,1,1,1);
            }
            ENDCG
        }
    }
}
