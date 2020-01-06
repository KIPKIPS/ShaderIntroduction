Shader "Shader/SurfaceShader_01"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5//用于计算高光程度
        _Metallic ("Metallic", Range(0,1)) = 0.0//材质的尽金属光泽度
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }//说明该物体是一个不透明物体
        LOD 200

        CGPROGRAM//CG语法块,直到ENDCG
        //pragma表示编译指令 按照surface语法 surf表示函数名称 Standard表示光照模型 
        //fullforwardshadows表示阴影类型
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
