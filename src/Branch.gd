extends Node3D
class_name Branch

func _init(leaves = null):
	var data_tool = MeshDataTool.new()
	var surface_tool = SurfaceTool.new()
	var mesh:CylinderMesh = CylinderMesh.new()

	# Randomizes the meshs properties - modify these to get different outcomes.
	randomize()
	mesh.radial_segments = randi_range(4, 8)
	mesh.height = randf_range(2, 4)
	mesh.top_radius = randf_range(0.1, 0.3)
	mesh.bottom_radius = randf_range(mesh.top_radius, 0.5)

	# Provide the MeshDataTool the mesh
	surface_tool.create_from(mesh, 0)
	var array_mesh = surface_tool.commit()
	data_tool.create_from_surface(array_mesh, 0)

	# Move random values. Modify these until u happy bro!
	var noise:FastNoiseLite = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()
	noise.frequency = 1.0 / randf_range(32, 128)
	var ampl = randf_range(0.4, 1.3)

	# Iterate through each vertex in the mesh
	for i in range(data_tool.get_vertex_count()):
		var vertex = data_tool.get_vertex(i)

		# Provide a noise value to the vertex
		var normal = vertex.normalized()
		var u = normal.x / noise.frequency
		var v = normal.y / noise.frequency
		var noise_value = noise.get_noise_2d(u, v)
		vertex = vertex + ((normal * noise_value) * ampl)

		data_tool.set_vertex(i, vertex)

	# Clean up
	array_mesh.clear_surfaces()

	# Build the mesh from the MeshDataTool with the SurfaceTool
	data_tool.commit_to_surface(array_mesh)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.set_smooth_group(-1)
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()

	# Create the instansiate and add it as well as the leaves
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = surface_tool.commit()
	mesh_instance.material_override = generate_random_material()

	if leaves != null:
		add_child(leaves)
		leaves.position = Vector3(0, mesh.height, 0)

	add_child(mesh_instance)

	mesh_instance.position = Vector3(0, mesh.height * 0.5, 0)

# genereates a new material with a random color
func generate_random_material():
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))
	return material
