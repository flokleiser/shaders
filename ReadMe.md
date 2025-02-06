# Testing shaders

### stuff to look at:
some book: https://thebookofshaders.com/05/

nice shader library: https://lygia.xyz/ , https://github.com/patriciogonzalezvivo/lygia
shader function visualizer: https://graphtoy.com/

directly displaying glsl: https://github.com/patriciogonzalezvivo/glslCanvas
display in terminal: https://github.com/patriciogonzalezvivo/glslViewer?tab=readme-ov-file
online editor: https://editor.thebookofshaders.com/

### defs
- mouse, resolution and time are initialized in typescript with "u_mouse", "u_resolution" & "u_time" 
- fragCoord is <ins>gl_FragCoord.xy</ins>
- void main() ends with setting the <ins>gl_FragColor</ins>

vec2 --> vector with 2 inputs, vec2(1.0,1.0)
vec3 --> vector with 3 inputs
vec4 --> etc etc

mat2 --> 2d matrix