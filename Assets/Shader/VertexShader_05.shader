Shader "Shader/VertexShader_05"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "../CGInclude/CGInclude.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
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
            float4  Frag(VertToFrag vtf):COLOR{
                return vtf.col;
            }
            ENDCG
        }
    }
}
