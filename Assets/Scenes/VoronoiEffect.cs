using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class VoronoiEffect : MonoBehaviour
{
    Material _mat;

    [SerializeField]
    Shader shader = null;

    [SerializeField]
    float cellSize = 32;

    private void Awake()
    {
        _mat = new Material(shader);
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (_mat != null)
        {
            _mat.SetFloat("_CellSize", cellSize);
            Graphics.Blit(source, destination, _mat);
        }
    }
}
