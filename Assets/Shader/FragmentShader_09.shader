//UV动画Shader
Shader "Shader/FragmentShader_09"
{
    Properties{
        _MainTex("MainTex",2D)=""{}
        _Amplitude("Amplitude",range(1,30))=10
        _Frequency("Frequency",range(0,0.1))=0.01
        _R("R",range(0,1))=0
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
            float _Amplitude;
            float _Frequency;
            float _R;
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
                //IN.uv+=_Time.x;
                //模拟水波
                //IN.uv+=sin(IN.uv*3.14*_Amplitude+_Time.y)*_Frequency;
                float2 uv=IN.uv;
                float dis=distance(float2(0.5,0.5),uv);//计算uv坐标到点击坐标的距离
                float scale=0;
                //if(dis<_R){
                    _Frequency*=saturate(1-dis/_R) ;
                    scale=sin(-dis*3.14*_Amplitude+_Time.y)*_Frequency;//dis前的负号代表向外扩散,正号代表向内扩散
                    uv=uv+uv*scale;
                //}
                
                float4 color=tex2D(_MainTex,uv);
                return color;
            }
            ENDCG
        }
        
    }
}
