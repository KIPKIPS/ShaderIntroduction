// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

//UV动画Shader
Shader "Shader/FragmentShader_13"
{
    SubShader
    {
    	Tags { "queue"="transparent" }
        Pass{
        	blend srcalpha oneminussrcalpha
        	ZWrite off 

            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
            	float4 color=float4(1,0,0,0.5);
            	return color;
            }
            ENDCG
        }
        
    }
}
