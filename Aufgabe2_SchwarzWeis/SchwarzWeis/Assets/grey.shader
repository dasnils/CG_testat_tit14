Shader "Custom/grey" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)

		_Glossiness ("Smoothness", Range(0,1)) = 0.2
		_Metallic ("Metallic", Range(0,1)) = 0.2
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert fullforwardshadows
		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};
		void surf (Input IN, inout SurfaceOutput o) {
		half4 c = tex2D (_MainTex, IN.uv_MainTex);
		o.Albedo =(c.r + c.g + c.b)/3;
		o.Alpha = c.a;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
