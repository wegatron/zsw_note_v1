
## Learning pipeline

| A# | Tasks |
| --- | ---- |
| 1 | Creating a window; setting up a render loop (where a teapot is drawn); reacting to user input |
| 2 | Writing, compiling, linking, and using custom shader programs; passing custom transformation matrices as uniforms to shaders; implementing an orbit camera and creating appropriate view matrices for rendering a scene, enabling depth testing |
|3 | Constructing box, cylinder, and sphere geometries as indexed triangle meshes; loading the data into GPU vertex buffer objects and creating vertex array objects; passing vertex positions as vertex attribute to shader programs, enabling primitive culling |
| 4 | Adding normals to geometric objects and passing them as additional vertex attributes; implementing Phong illumination [28] combined with Gouraud shading [29] and Phong shading [28] in shaders; illumination from different types of light sources |
| 5 | Adding texture coordinates to geometric objects and passing them as additional vertex attributes; loading images into GPU memory, creating mipmaps, sampling from textures in shaders |


## Advanced

Topics include proper implementation of normal mapping using tangent space, handling a large number of light sources, hardware tessellation, view-frustum and backface culling in tessellation control shaders, dynamically adaptive levels of tessellation, deferred shading, deferred shading in combination with multisample anti-aliasing, manual multisample resolve in compute shaders, tile-based deferred shading, physically based shading, screen-space ambient occlusion, tone mapping, temporal anti-aliasing, and real-time ray tracing using ray query and ray tracing pipelines.

course site: https://www.cg.tuwien.ac.at/courses/ARTR/VU

## reference
https://www.youtube.com/watch?v=GiKbGWI4M-Y&list=PLmIqTlJ6KsE1Jx5HV4sd2jOe3V1KMHHgn&index=7