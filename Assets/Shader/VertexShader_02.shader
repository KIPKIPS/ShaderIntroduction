// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shader/VertexShader_02"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag 

            //获取UnityObject的信息
            struct Input{
                float4 vertex :POSITION;//用模型空间的顶点坐标来填充vertex
                float3 normal:NORMAL;//用模型空间的法线来填充normal
                float4 texcoord:TEXCOORD0 ;//用模型空间的纹理来填充texcoord0; 
            };
            //顶点着色器的输出
            struct VertToFrag{
                float4  pos:POSITION;//pos包含了顶点在裁剪空间中的位置信息
                fixed3 color:COLOR0;//存储颜色信息

            };
            VertToFrag vert(Input input):POSITION{
                VertToFrag output;//声明输出结构

                output.pos=UnityObjectToClipPos(input.vertex);//将物体的顶点信息转换为通信媒介的位置
                //把分量范围映射到[0,1]存储到color变量中传递给片元着色器
                output.color=input.normal*1+fixed3(0.5,0.5,0.5);
                return output;
            }
            //片元着色器
            fixed4 frag(VertToFrag v2f):SV_Target{
                return fixed4(v2f.color,1.0);
            }
            ENDCG
        }
    }
}
