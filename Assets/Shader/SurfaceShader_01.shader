Shader "Shader/SurfaceShader_01"
{
    Properties
    {
        //_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //_Glossiness ("Smoothness", Range(0,1)) = 0.5//用于计算高光程度
        //_Metallic ("Metallic", Range(0,1)) = 0.0//材质的尽金属光泽度
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "queue"="transparent" }//说明该物体是一个不透明物体
        LOD 200

        CGPROGRAM//CG语法块,直到ENDCG
        //pragma表示编译指令 按照surface语法 surf表示函数名称 Standard表示光照模型 
        //fullforwardshadows表示阴影类型
        #pragma surface surf Lambert alpha addshadow
        #pragma target 3.0
        struct Input
        {
            //如果Properties里声明了一个MainTex参数,这里必须使用uv_MainTex/uv2_MainTex
            float2 uv_MainTex;
        };
        //fixed4 _Color;//四维向量
        sampler2D _MainTex;//2D贴图
        //half _Glossiness;//浮点
        //half _Metallic;//浮点
        
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)
        //PBS基于物理的引擎
        //in代表这个参数是输入,out代表这个参数是输出,inout代表这个参数既是输入又是输出
        void surf (Input IN, inout SurfaceOutput o)
        {
            //SurfaceOutputStandard结构体的属性
            //Albedo漫反射光照 
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex); //* _Color;
            o.Albedo = c.rgb;
            //o.Metallic = _Metallic;
            //o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    //FallBack "Diffuse"
}
