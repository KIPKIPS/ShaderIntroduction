// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

//UV动画Shader
Shader "Shader/FragmentShader_10"
{
    Properties{
        _MainTex("MainTex",2D)=""{}
        _Amplitude("Amplitude",range(1,30))=10
        _Frequency("Frequency",range(0,0.1))=0.01
        _R("R",range(0,1))=0
        _Blurry("Blurry",range(0,1000))=5
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
            #pragma target 3.0

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Amplitude;
            float _Frequency;
            float _R;
            float _Blurry;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 uv:TEXCOORD0;
                float z:TEXCOORD1;//摄像机深度
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                vtf.uv=TRANSFORM_TEX(v.texcoord.xy,_MainTex);

                vtf.z=mul(unity_ObjectToWorld,v.vertex).z;
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                //粗纹理模糊实验
                //float4 color=tex2D(_MainTex,uv);
                // float2 offset_uv=(0.01,0.01);
                // float2 uv=IN.uv;
                // float4 color=tex2D(_MainTex,uv);

                // uv=IN.uv+offset_uv;//偏移采样
                // color.rgb+=tex2D(_MainTex,uv);

                // uv=IN.uv-offset_uv;//偏移采样 
                //color.rgb+=tex2D(_MainTex,uv);
                //color.rgb/=3;

                //使用导数的方式来采样 需要target 3.0支持
                // float dx =ddx(IN.uv.x)*_Blurry;//对uv.x求导数
                // float2 dsdx =float2 (dx,dx);
                // float dy =ddy(IN.uv.y)*_Blurry;//对uv.y求导数
                // float2 dsdy =float2 (dy,dy);
                // float4 color=tex2D(_MainTex,IN.uv,dsdx,dsdy);

                //偏移模糊 旋转远离屏幕模糊
                float2 dsdx=ddx(IN.z)*_Blurry;
                float2 dsdy=ddy(IN.z)*_Blurry;

                float4 color=tex2D(_MainTex,IN.uv,dsdx,dsdy);

                //偏移模糊 
                return color;
            }
            ENDCG
        }
        
    }
}
