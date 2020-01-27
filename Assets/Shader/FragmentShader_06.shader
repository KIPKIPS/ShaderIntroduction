Shader "Shader/FragmentShader_06"
{
    Properties{
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                return float4(1,1,1,1);
            }
            ENDCG
        }
        
    }
}
