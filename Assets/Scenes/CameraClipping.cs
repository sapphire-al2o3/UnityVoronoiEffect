using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class CameraClipping : MonoBehaviour
{
	void Awake()
    {


		var commandBuffer = new CommandBuffer();
		commandBuffer.name = "Clipping";
		commandBuffer.EnableScissorRect(new Rect(0, 0, 0, 0));

		commandBuffer.SetViewport(new Rect(0, 0, 100, 100));
		var camera = GetComponent<Camera>();

		//var material = new Material(Shader.Find("Standard"));
		//commandBuffer.DrawMesh(_mesh, Matrix4x4.identity, material, 0, 0);

		camera.AddCommandBuffer(CameraEvent.AfterForwardOpaque, commandBuffer);

		Debug.Log(camera.commandBufferCount);
	}
}
