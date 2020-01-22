// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/FragmentShader_03"
{
    
    SubShader
    {
        
        //着色通道
        Pass{
        	
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 mvp=UNITY_MATRIX_MVP;
                vtf.pos=mul(mvp,v.vertex);
                
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag vtf):COLOR{
                return float4(1,1,1,1);
            }
            ENDCG
        }
    }
}
