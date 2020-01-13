Shader "Shader/VertexShader_05"
{
    Properties{
        _MainColor("Main Color",Color)=(1,0.5,0.5,1)
    }

    SubShader
    {
        Pass{
            CGPROGRAM
            #include "../CGInclude/CGInclude.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            float4 _MainColor;
            uniform float4 _SecondColor;//这个变量由应用程序提供,默认零值

            //输入结构体
            struct Input{
                float2 pos:POSITION;
                float4 col:COLOR;
            };

            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float2 objPos:TEXCOORD0;//纹理坐标
                float4 col:COLOR;
            };

            VertToFrag Vert(Input input){
                VertToFrag vtf;
                vtf.pos=float4 (input.pos,0,1);
                vtf.objPos=float2 (Func_02(),0);
                vtf.col=input.col;
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                //return vtf.col;
                //return _MainColor*0.5+_SecondColor*0.5;
                return lerp(_MainColor,_SecondColor,0.5);//参数代表后一个颜色的比例
            }
            ENDCG
        }
    }
}
