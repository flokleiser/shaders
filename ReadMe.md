# Testing shaders

### stuff to look at:
some book: https://thebookofshaders.com/05/

- nice shader library: https://lygia.xyz/ , https://github.com/patriciogonzalezvivo/lygia
- shader function visualizer: https://graphtoy.com/

- directly displaying glsl: https://github.com/patriciogonzalezvivo/glslCanvas
- display in terminal: https://github.com/patriciogonzalezvivo/glslViewer?tab=readme-ov-file
- online editor: https://editor.thebookofshaders.com/

### defs
- mouse, resolution and time are initialized in typescript with <b><ins>"u_mouse"</ins></b>,<b><ins> "u_resolution"</ins></b> & <ins><b>"u_time" </ins></b>
- fragCoord is <ins><b>gl_FragCoord.xy</ins></b>
- void main() ends with setting the <ins><b>gl_FragColor</ins></b>
