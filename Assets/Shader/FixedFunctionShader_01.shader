Shader "Shader/FixedFunctionShader_01"
{
    Properties {
        _Color("Main Color",Color)=(1,1,1,1)
        _Ambient("Ambient",Color)=(0.3,0.3,0.3,0.3)
        _Specular("Specular",Color)=(1,1,1,1)
    
        _Shininess("Shininess", range(0,8))=4
        _Emission("Emission",Color)=(1,1,1,1)
    }
    SubShader
    {
        Pass{
            //color(1,0,0,1)
            //color [_Color]
            Material {
                Diffuse[_Color]
                Ambient[_Ambient]
                Specular[_Specular]
                Shininess[_Shininess]
                Emission[_Emission]
            }
            Lighting On
            separatespecular On
        }
    }
}
