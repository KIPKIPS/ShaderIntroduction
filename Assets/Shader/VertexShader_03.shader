Shader "Shader/VertexShader_03"
{
    SubShader
    {
        Pass{
            CGPROGRAM
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
#pragma exclude_renderers gles
            #pragma vertex vert
            #pragma fragment frag 
            #define MACROFL FL4(f4.ba,f3.xz);//宏定义
            typedef float4 FL4;

            struct Input{
                float4 vertex :POSITION;//用模型空间的顶点坐标来填充vertex
                float3 normal:NORMAL;//用模型空间的法线来填充normal
                float4 texcoord:TEXCOORD0 ;//用模型空间的纹理来填充texcoord0; 
            };
            float4  vert(Input i):SV_POSITION{
                return UnityObjectToClipPos(i.vertex );
            }
            void frag(out float4 col:COLOR){
        	    float2 f2=float2 (1,0);
        	    float3 f3=float3 (1,0,1);
        	    float4 f4=float4 (1,1,0,1);

        	    FL4 fl4=MACROFL;
        	    col=fl4;

        	    //矩阵
        	    float2x4 M2x4={fl4,{0,1,0,1}};
        	    col=M2x4[0];

        	    //数组
        	    float arr[4]={1,0.5,0.5,1};
        	    col=float4 (arr[0],arr[1],arr[2],arr[3]);
            }
            ENDCG
        }
    }
}
