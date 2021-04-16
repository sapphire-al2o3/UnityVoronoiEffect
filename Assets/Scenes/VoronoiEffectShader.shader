Shader "Hidden/VoronoiEffectShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_CellSize ("CellSize", Float) = 16
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

			float2 random2(float2 p)
			{
				return frac(sin(float2(dot(p, float2(127.1, 311.7)), dot(p, float2(269.5, 183.3)))) * 43758.5453);
			}

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
			float _CellSize;

            fixed4 frag (v2f i) : SV_Target
            {
                
				float2 st = i.uv * _CellSize;
				float aspect = _ScreenParams.x / _ScreenParams.y;
				st.x *= aspect;

				float2 ist = floor(st);
				float2 fst = frac(st);

				float mind = 1;
				float2 q = i.uv;

				for (int y = -1; y <= 1; y++)
				{
					for (int x = -1; x <= 1; x++)
					{
						float2 neighbor = float2(float(x), float(y));
						float2 p = random2(ist + neighbor);

						float2 diff = neighbor + p - fst;
						float d = length(diff);
						if (mind > d)
						{
							mind = d;
							q = neighbor + p;
						}
						//mind = min(mind, d);
					}
				}
				q = (q + ist) / _CellSize;
				q.x /= aspect;
				fixed4 col = tex2D(_MainTex, q);
				//fixed4 col = fixed4(0, 0, 0, 1);
				//col.rgb += mind;
                return col;
            }
            ENDCG
        }
    }
}
