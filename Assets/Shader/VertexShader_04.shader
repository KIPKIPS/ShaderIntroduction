Shader "Shader/VertexShader_04"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "../CGInclude/CGInclude.cginc"
            #pragma exclude_renderers gles
            #pragma vertex vert
            #pragma fragment frag  
            
            //获取场景物体信息
            struct Input{
                float2 vertex :POSITION;//用模型空间的顶点坐标来填充vertex
                float3 normal:NORMAL;//用模型空间的法线来填充normal
                float4 texcoord:TEXCOORD0 ;//用模型空间的纹理来填充texcoord0; 
            };
            //通信结构体
            struct Trans{
            	float4 transPos:POSITION;
            	fixed4 color:COLOR0;//存储颜色信息
            }; 
            Trans vert(Input input):POSITION{
            	Trans t;
            	t.transPos=float4 (input.vertex ,0,1);
            	if(t.transPos.x<0&&t.transPos.y<0){
                	t.color= fixed4(1,0,0,1);
                }
                else if(t.transPos.x<0){
                	t.color= fixed4(0,1,0,1);
                }
                else if(t.transPos.y>0){
                	t.color= fixed4(1,1,0,1);
                }
                else{
                	t.color= fixed4(0,0,1,1);
                }
                return t;
                
            }
            
            fixed4 frag(Trans t):SV_Target{
            	//int i=0;
            	//while(i<10){
            	//	i++;
            	//}
            	//if(i==10)
            	//t.color=float4 (0,0,0,1);
            	Func(t.color);
        	    return t.color;
            }
            ENDCG
        }
    }
}
