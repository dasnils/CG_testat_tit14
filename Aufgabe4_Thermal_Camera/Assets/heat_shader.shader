﻿Shader "Unlit/heat_shader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_ThermalSourcePos ("Position der Wärmequelle",Vector) = (0,0,0)
		_Color("Farbe", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;

				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _ThermalSourcePos;
			float4 _ThermalSourceVector;
			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = mul(unity_ObjectToWorld, v.vertex); //Objektkoordinaten in Weltkoordinaten umrechnen
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				
				float heat_obj_distance = distance(i.uv, _ThermalSourcePos);   //Distanz zwischen Heatsource und Objekt

				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
