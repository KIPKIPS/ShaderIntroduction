// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

//UV动画Shader
Shader "Shader/FragmentShader_15"
{
    Properties{
        
    }
    SubShader
    {
        Tags { "queue"="transparent" }
        Pass{
        	Blend   SrcAlpha oneminussrcalpha
        	ztest Greater
        	ZWrite on 
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 uv:TEXCOORD0; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
            	float4 color=float4(1,1,0,1);//黄色
            	return color;
            }
            ENDCG
        }
        Pass{
        	ztest Less
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 uv:TEXCOORD0; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
            	float4 color=float4(0,0,1,1);//蓝色
            	return color;
            }
            ENDCG
        }
        
    }
}
