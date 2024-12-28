import { loadShaderFile } from "./shaderloader.js";
import { compileShader } from "./utils.js";
import { createProgram } from "./utils.js";

async function main() {

    const canvas = document.getElementById("glCanvas") as HTMLCanvasElement;

    if (!canvas) throw new Error("no canvas");

    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    const gl = canvas.getContext("webgl") as WebGL2RenderingContext || canvas.getContext("experimental-webgl");

    try {
        const vertexShaderSource = await loadShaderFile("./shaders/vert.glsl");
        const fragmentShaderSource = await loadShaderFile("./shaders/frag.glsl");
        const vertexShader = compileShader(gl, vertexShaderSource, gl.VERTEX_SHADER);
        const fragmentShader = compileShader(gl, fragmentShaderSource, gl.FRAGMENT_SHADER);
        if (!vertexShader || !fragmentShader) {
            return;
        }

        const shaderProgram = createProgram(gl, vertexShader, fragmentShader);
        gl.useProgram(shaderProgram);
        

        const resolutionUniformLocation = gl.getUniformLocation(shaderProgram, "uResolution");
        gl.uniform2f(resolutionUniformLocation, canvas.width, canvas.height);

        const vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition");
        gl.enableVertexAttribArray(vertexPositionAttribute);

        const vertices = new Float32Array([
            -1.0, -1.0,
            1.0, -1.0,
            -1.0, 1.0,
            1.0, 1.0
        ]);

        const vertexBuffer = gl.createBuffer();
        gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
        gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);

        gl.vertexAttribPointer(vertexPositionAttribute, 2, gl.FLOAT, false, 0, 0);

        gl.clearColor(0.0, 0.0, 0.0, 1.0);

        let startTime = Date.now();

        function render() {
            let currentTime = (Date.now() - startTime) / 1000.0;
            gl.uniform1f(gl.getUniformLocation(shaderProgram, "u_time"), currentTime);

            gl.clear(gl.COLOR_BUFFER_BIT);
            gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);

            requestAnimationFrame(render);
        }

        render();

        } 

    catch (error) {
        console.error(error);
    }
}

main();