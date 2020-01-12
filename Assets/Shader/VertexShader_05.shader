Shader "Shader/VertexShader_05"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag 

            struct VertToFrag{
                float4 pos:POSITION ;
                float2 objPos:TEXCOORD0;
                float4 col:COLOR;
            };

            VertToFrag Vert(in float2 objPos:POSITION ){
                VertToFrag vtf;
                vtf.pos=float4 (objPos,0,1);
                vtf.col=float4 (1,0,0,1);//改变片元颜色
                vtf.objPos=objPos;
                return vtf;
            }
            float4  Frag(VertToFrag input):COLOR{
                return input.col;
            }
            ENDCG
        }
    }
}
