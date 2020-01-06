// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shader/VertexShader_01"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag 
            //顶点着色器
            struct Input{
                float4 vertex :POSITION;//用模型空间的顶点坐标来填充vertex
                float3 normal:NORMAL;//用模型空间的法线来填充normal
                float4 texcoord:TEXCOORD0 ;//用模型空间的纹理来填充texcoord0; 
            };
            float4  vert(Input i):SV_POSITION{
                return UnityObjectToClipPos(i.vertex );
            }
            //片元着色器
            fixed4 frag():SV_Target{
                return fixed4(0,1,0,1);
            }
            ENDCG
        }
    }
}
