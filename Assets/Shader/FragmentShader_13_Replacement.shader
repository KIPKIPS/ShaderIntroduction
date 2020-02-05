// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

//FragmentShader_13的置换shader
Shader "Shader/FragmentShader_13_Replacement"
{
    SubShader
    {
    	Tags {"rendertype"="transparent"}
        Pass{
        
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 depth:TEXCOORD0; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                vtf.depth=vtf.pos.zw; 
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                float depth=Linear01Depth(IN.depth.x/IN.depth.y);

            	float4 color=float4(depth,0,0,1);
            	return color;
            }
            ENDCG
        }
        
    }
}
