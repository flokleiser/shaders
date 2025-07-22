#version 300 es
precision mediump float;

in vec2 aVertexPosition;
out vec2 vUV;

void main() {
    vUV = aVertexPosition * 0.5 + 0.5;
    gl_Position = vec4(aVertexPosition, 0.0, 1.0);
}

// attribute vec4 aVertexPosition;
// void main(void) {
//     gl_Position = aVertexPosition;
// }
