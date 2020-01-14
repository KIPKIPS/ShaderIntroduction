// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_08"
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
            
            VertToFrag Vert(appdata_base adb){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,adb.vertex);

                float x=vtf.pos.x/vtf.pos.w;
                if(x<0){
                    vtf.color=float4 (1,0,0,1);
                }
                else{
                    vtf.color=float4 (0,0,1,1);
                }
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color;
            }
            ENDCG
        }
    }
}
