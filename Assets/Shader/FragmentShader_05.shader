//颜色过渡Shader
Shader "Shader/FragmentShader_05"
{
    Properties{
        _MainColor("MainColor",Color)=(0,1,0,1)
        _SecondColor("SecondColor",Color)=(0,0,1,1)
        _Scale("Scale",range(-0.51,0.51))=0.0
        _R("R",range(0.,0.51))=0.2
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            float4 _MainColor;
            float4 _SecondColor;
            uniform float _Scale;
            float _R;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float4 color:COLOR;
                float4 vertex :TEXCOORD0; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                vtf.vertex=v.vertex;
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                //颜色按比例填充模型
                //return lerp(_MainColor,_SecondColor,(IN.vertex.y-_Scale)/abs(IN.vertex.y-_Scale)+1);
                // if(IN.vertex.y>_Scale){
                //     return _MainColor*(IN.vertex.y-_Scale);
                // }else{
                //     return _SecondColor*(_Scale-IN.vertex.y);
                // }
                if(IN.vertex.y>_Scale+_R){
                    return _MainColor;
                } 
                else if(IN.vertex.y>_Scale&&IN.vertex.y<_Scale+_R){
                    float d=IN.vertex.y-_Scale;
                    d=(1-d/_R)-0.5;//取反转值
                    d=saturate(d);
                    return lerp(_MainColor,_SecondColor,d);
                }
                if(IN.vertex.y<=_Scale-_R){
                    return _SecondColor;
                }
                else if(IN.vertex.y<_Scale&&IN.vertex.y>_Scale-_R){
                    float d=_Scale-IN.vertex.y;
                    d=(1-d/_R)-0.5;//取反转值
                    d=saturate(d);
                    return lerp(_SecondColor,_MainColor,d);
                }
                return float4 (0,0,0,1);

                //return _MainColor*(IN.vertex.y-_Scale)+_SecondColor*(_Scale-IN.vertex.y);
                //return IN.color;
            }
            ENDCG
        }
        
    }
}
