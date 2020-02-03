// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

//UV动画Shader
Shader "Shader/FragmentShader_12"
{
    Properties{
        _MainTex("MainTex",2D)=""{}
        _F("F",range(1,10))=1
        _Speed("Speed",range(-10,100))=5
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _F;
            float _Speed;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 uv:TEXCOORD0;
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                vtf.uv=TRANSFORM_TEX(v.texcoord.xy,_MainTex);

                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                float2 uv=IN.uv;
                float offset_uv=0.05*sin(IN.uv*_F+_Time.x*_Speed);//-1到1的值,使uv不断的变化
                uv+=offset_uv;
                float4 color_1=tex2D(_MainTex,uv);

                uv=IN.uv;
                uv-=offset_uv;
                float4 color_2=tex2D(_MainTex,uv);
                return 0.5*(color_1+color_2);
            }
            ENDCG
        }
        
    }
}
