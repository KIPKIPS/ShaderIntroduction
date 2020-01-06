Shader "Shader/VertexShader_01"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag 
            //顶点程序
            void vert(in float2 objPos:POSITION,out float4 pos:POSITION){
                pos=float4 (objPos,0,1);
            }
            //片段程序
            void frag(out float4 col:COLOR ,in float4 pos:POSITION){
                //col=float4 (0,1,0,1);
                col=pos;
            }
            ENDCG
        }
    }
}
