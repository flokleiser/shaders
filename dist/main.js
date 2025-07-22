// import { loadShaderFile } from "./shaderloader.js";
// import { compileShader } from "./utils.js";
// import { createProgram } from "./utils.js";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
// async function main() {
//     const canvas = document.getElementById("glCanvas") as HTMLCanvasElement;
//     const audioCtx = new AudioContext();
//     const analyser = audioCtx.createAnalyser();
//     analyser.fftSize = 128;
//     const frequencyData = new Uint8Array(analyser.frequencyBinCount);
//     const normalizedData = new Float32Array(frequencyData.length);
//     const audio = new Audio('../audio/check1.mp3');
//     audio.loop = true;
//     audio.crossOrigin = 'anonymous';
//     const source = audioCtx.createMediaElementSource(audio);
//     source.connect(analyser);
//     analyser.connect(audioCtx.destination);
//     const audioToggle = document.getElementById("audioToggle") as HTMLButtonElement;
//     let isPlaying = false;
//     audioToggle.addEventListener("click", async () => {
//         if (audioCtx.state === "suspended") {
//             await audioCtx.resume();
//         }
//         if (!isPlaying) {
//             audio.play();
//             isPlaying = true;
//             audioToggle.textContent = "⏸️ Pause";
//         } else {
//             audio.pause();
//             isPlaying = false;
//             audioToggle.textContent = "▶️ Play";
//         }
//     });
//     if (!canvas) throw new Error("no canvas");
//     canvas.width = window.innerWidth;
//     canvas.height = window.innerHeight;
//     // const gl = canvas.getContext("webgl") as WebGL2RenderingContext || canvas.getContext("experimental-webgl");
//     const gl = canvas.getContext("webgl2") as WebGL2RenderingContext;
//     if (!gl) throw new Error("WebGL2 not supported");
//     try {
//         const vertexShaderSource = await loadShaderFile("./shaders/vert.glsl");
// 		const fragmentShaderSource = await loadShaderFile("./shader_tests/live.glsl");
//         const vertexShader = compileShader(gl, vertexShaderSource, gl.VERTEX_SHADER);
//         const fragmentShader = compileShader(gl, fragmentShaderSource, gl.FRAGMENT_SHADER);
//         if (!vertexShader || !fragmentShader) {
//             return;
//         }
//         const shaderProgram = createProgram(gl, vertexShader, fragmentShader);
//         gl.useProgram(shaderProgram);
//         const resolutionUniformLocation = gl.getUniformLocation(shaderProgram, "u_resolution");
//         gl.uniform2f(resolutionUniformLocation, canvas.width, canvas.height);
//         const vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition");
//         gl.enableVertexAttribArray(vertexPositionAttribute);
//         const uMouseLocation = gl.getUniformLocation(shaderProgram, 'u_mouse');
//         canvas.addEventListener('mousemove', (event) => {
//             const mouseX = event.clientX / canvas.width;
//             const mouseY = 1.0 - event.clientY / canvas.height;
//             const state = 1.0;
//             const extra = 0.0;
//             gl.uniform4f(uMouseLocation, mouseX, mouseY, state, extra);
//         });
//         const uAudioDataLocation = gl.getUniformLocation(shaderProgram, "u_audio");
//         const vertices = new Float32Array([
//             -1.0, -1.0,
//             1.0, -1.0,
//             -1.0, 1.0,
//             1.0, 1.0
//         ]);
//         const vertexBuffer = gl.createBuffer();
//         gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
//         gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);
//         gl.vertexAttribPointer(vertexPositionAttribute, 2, gl.FLOAT, false, 0, 0);
//         gl.clearColor(0.0, 0.0, 0.0, 1.0);
//         let startTime = Date.now();
//         function render() {
//             let currentTime = (Date.now() - startTime) / 1000.0;
//             gl.uniform1f(gl.getUniformLocation(shaderProgram, "u_time"), currentTime);
//             analyser.getByteFrequencyData(frequencyData);
//             for (let i = 0; i < frequencyData.length; i++) {
//                 normalizedData[i] = frequencyData[i] / 255;
//             }
//             gl.uniform1fv(uAudioDataLocation, normalizedData);
//             gl.clear(gl.COLOR_BUFFER_BIT);
//             gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
//             requestAnimationFrame(render);
//         }
//         render();
//         } 
//     catch (error) {
//         console.error(error);
//     }
// }
// main();
import { loadShaderFile } from "./shaderloader.js";
import { compileShader } from "./utils.js";
import { createProgram } from "./utils.js";
function main() {
    return __awaiter(this, void 0, void 0, function* () {
        const canvas = document.getElementById("glCanvas");
        if (!canvas)
            throw new Error("no canvas");
        const gl = canvas.getContext("webgl2");
        if (!gl)
            throw new Error("WebGL2 not supported");
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        const audioCtx = new AudioContext();
        const analyser = audioCtx.createAnalyser();
        analyser.fftSize = 128;
        const frequencyData = new Uint8Array(analyser.frequencyBinCount);
        const normalizedData = new Float32Array(frequencyData.length);
        const audio = new Audio('../audio/check1.mp3');
        audio.loop = true;
        audio.crossOrigin = 'anonymous';
        const source = audioCtx.createMediaElementSource(audio);
        source.connect(analyser);
        analyser.connect(audioCtx.destination);
        const audioToggle = document.getElementById("audioToggle");
        let isPlaying = false;
        audioToggle.addEventListener("click", () => __awaiter(this, void 0, void 0, function* () {
            if (audioCtx.state === "suspended") {
                yield audioCtx.resume();
            }
            if (!isPlaying) {
                audio.play();
                isPlaying = true;
                audioToggle.textContent = "⏸️ Pause";
            }
            else {
                audio.pause();
                isPlaying = false;
                audioToggle.textContent = "▶️ Play";
            }
        }));
        try {
            const vertexShaderSource = yield loadShaderFile("./shader_tests/vert.glsl");
            const fragmentShaderSource = yield loadShaderFile("./shader_tests/live.glsl");
            const vertexShader = compileShader(gl, vertexShaderSource, gl.VERTEX_SHADER);
            const fragmentShader = compileShader(gl, fragmentShaderSource, gl.FRAGMENT_SHADER);
            if (!vertexShader || !fragmentShader)
                return;
            const shaderProgram = createProgram(gl, vertexShader, fragmentShader);
            gl.useProgram(shaderProgram);
            const resolutionUniformLocation = gl.getUniformLocation(shaderProgram, "u_resolution");
            gl.uniform2f(resolutionUniformLocation, canvas.width, canvas.height);
            const uTimeLocation = gl.getUniformLocation(shaderProgram, "u_time");
            const uMouseLocation = gl.getUniformLocation(shaderProgram, "u_mouse");
            const uAudioDataLocation = gl.getUniformLocation(shaderProgram, "u_audio");
            canvas.addEventListener('mousemove', (event) => {
                const mouseX = event.clientX / canvas.width;
                const mouseY = 1.0 - event.clientY / canvas.height;
                gl.uniform4f(uMouseLocation, mouseX, mouseY, 1.0, 0.0);
            });
            const vertices = new Float32Array([
                -1.0, -1.0,
                1.0, -1.0,
                -1.0, 1.0,
                1.0, 1.0
            ]);
            const vao = gl.createVertexArray();
            gl.bindVertexArray(vao);
            const vertexBuffer = gl.createBuffer();
            gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
            gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);
            const vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition");
            gl.enableVertexAttribArray(vertexPositionAttribute);
            gl.vertexAttribPointer(vertexPositionAttribute, 2, gl.FLOAT, false, 0, 0);
            gl.bindVertexArray(null);
            gl.clearColor(0.0, 0.0, 0.0, 1.0);
            let startTime = Date.now();
            function render() {
                const currentTime = (Date.now() - startTime) / 1000.0;
                gl.uniform1f(uTimeLocation, currentTime);
                analyser.getByteFrequencyData(frequencyData);
                for (let i = 0; i < frequencyData.length; i++) {
                    normalizedData[i] = frequencyData[i] / 255;
                }
                gl.uniform1fv(uAudioDataLocation, normalizedData);
                gl.clear(gl.COLOR_BUFFER_BIT);
                gl.bindVertexArray(vao);
                gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
                requestAnimationFrame(render);
            }
            render();
        }
        catch (error) {
            console.error(error);
        }
    });
}
main();
