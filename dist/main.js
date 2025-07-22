var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
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
        const dpr = window.devicePixelRatio || 1;
        canvas.width = window.innerWidth * dpr;
        canvas.height = window.innerHeight * dpr;
        canvas.style.width = `${window.innerWidth}px`;
        canvas.style.height = `${window.innerHeight}px`;
        gl.viewport(0, 0, canvas.width, canvas.height);
        const audioCtx = new AudioContext();
        const analyser = audioCtx.createAnalyser();
        analyser.fftSize = 128;
        // analyser.fftSize = 512;
        const frequencyData = new Uint8Array(analyser.frequencyBinCount);
        const normalizedData = new Float32Array(frequencyData.length);
        const audio = document.createElement('audio');
        // audio.src = '../audio/check1.mp3';
        audio.src = '../audio/ugh.mp3';
        audio.controls = true;
        audio.loop = true;
        audio.crossOrigin = 'anonymous';
        audio.style.position = "absolute";
        audio.style.top = "10px";
        audio.style.left = "10px";
        audio.style.zIndex = "1000";
        audio.style.width = "100%";
        document.body.appendChild(audio);
        const source = audioCtx.createMediaElementSource(audio);
        source.connect(analyser);
        analyser.connect(audioCtx.destination);
        let isPlaying = false;
        window.addEventListener("keydown", (event) => __awaiter(this, void 0, void 0, function* () {
            if (event.code === "Space") {
                event.preventDefault();
                if (audioCtx.state === "suspended") {
                    yield audioCtx.resume();
                }
                if (!isPlaying) {
                    audio.play();
                    isPlaying = true;
                }
                else {
                    audio.pause();
                    isPlaying = false;
                }
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
            // console.log('Canvas size:', canvas.width, 'x', canvas.height);
            // console.log('CSS size:', canvas.style.width, 'x', canvas.style.height);
            // console.log('DPR:', dpr);
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
