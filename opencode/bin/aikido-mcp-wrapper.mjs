#!/usr/bin/env node

import { spawn } from "node:child_process";
import { appendFileSync } from "node:fs";

const debugLogPath = "/Users/stefanbilliet/.local/share/opencode/log/aikido-mcp-wrapper.log";

debug("wrapper starting");

const apiKey = await readAikidoApiKeyFromKeychain();
debug("api key loaded from keychain");

const aikido = spawn(
  "/opt/homebrew/bin/npm",
  [
    "--loglevel=error",
    "exec",
    "--yes",
    "--",
    "@aikidosec/mcp",
  ],
  {
    env: {
      ...process.env,
      AIKIDO_API_KEY: apiKey,
      LOG_LEVEL: "error",
    },
    stdio: ["pipe", "pipe", "pipe"],
  },
);

aikido.stderr.on("data", (chunk) => {
  debug(`aikido stderr: ${chunk.toString("utf8").trim()}`);
  process.stderr.write(chunk);
});

debug(`aikido spawned pid=${aikido.pid ?? "unknown"}`);

let inputBuffer = Buffer.alloc(0);
let expectedBodyLength = null;
let protocolMode = null;

process.stdin.on("data", (chunk) => {
  debug(`stdin chunk bytes=${chunk.length}`);
  inputBuffer = Buffer.concat([inputBuffer, chunk]);
  forwardAvailableMessagesToAikido();
});

process.stdin.on("end", () => {
  aikido.stdin.end();
});

aikido.on("exit", (code, signal) => {
  debug(`aikido exited code=${code ?? "null"} signal=${signal ?? "null"}`);
  if (signal) {
    process.kill(process.pid, signal);
    return;
  }

  process.exit(code ?? 1);
});

let outputBuffer = "";

aikido.stdout.on("data", (chunk) => {
  if (protocolMode === "line") {
    debug(`forwarding raw aikido stdout bytes=${chunk.length}`);
    process.stdout.write(chunk);
    return;
  }

  debug(`aikido stdout chunk bytes=${chunk.length}`);
  outputBuffer += chunk.toString("utf8");

  for (;;) {
    const newlineIndex = outputBuffer.indexOf("\n");
    if (newlineIndex === -1) {
      return;
    }

    const line = outputBuffer.slice(0, newlineIndex).trim();
    outputBuffer = outputBuffer.slice(newlineIndex + 1);

    if (line.length === 0) {
      continue;
    }

    const body = Buffer.from(line, "utf8");
    debug(`forwarding aikido response bytes=${body.length}`);
    process.stdout.write(`Content-Length: ${body.length}\r\n\r\n`);
    process.stdout.write(body);
  }
});

function forwardAvailableMessagesToAikido() {
  if (protocolMode === null) {
    const firstNonWhitespace = inputBuffer.toString("utf8", 0, Math.min(inputBuffer.length, 16)).trimStart()[0];
    if (firstNonWhitespace === "{") {
      protocolMode = "line";
      debug("detected line-delimited JSON MCP mode");
    } else if (inputBuffer.length > 0) {
      protocolMode = "header";
      debug("detected header-framed MCP mode");
    }
  }

  if (protocolMode === "line") {
    debug(`forwarding raw opencode stdin bytes=${inputBuffer.length}`);
    aikido.stdin.write(inputBuffer);
    inputBuffer = Buffer.alloc(0);
    return;
  }

  for (;;) {
    if (expectedBodyLength === null) {
      const crlfHeaderEnd = inputBuffer.indexOf("\r\n\r\n");
      const lfHeaderEnd = inputBuffer.indexOf("\n\n");
      const usesCrlf = crlfHeaderEnd !== -1;
      const headerEnd = usesCrlf ? crlfHeaderEnd : lfHeaderEnd;
      if (headerEnd === -1) {
        return;
      }

      const headers = inputBuffer.slice(0, headerEnd).toString("utf8");
      const contentLengthHeader = headers
        .split(/\r?\n/)
        .find((header) => header.toLowerCase().startsWith("content-length:"));

      if (!contentLengthHeader) {
        throw new Error("Missing Content-Length header in MCP message.");
      }

      expectedBodyLength = Number(contentLengthHeader.split(":")[1].trim());
      inputBuffer = inputBuffer.slice(headerEnd + (usesCrlf ? 4 : 2));
      debug(`parsed content length=${expectedBodyLength}`);
    }

    if (inputBuffer.length < expectedBodyLength) {
      return;
    }

    const body = inputBuffer.slice(0, expectedBodyLength).toString("utf8");
    debug(`forwarding opencode request bytes=${expectedBodyLength}`);
    aikido.stdin.write(`${body}\n`);

    inputBuffer = inputBuffer.slice(expectedBodyLength);
    expectedBodyLength = null;
  }
}

async function readAikidoApiKeyFromKeychain() {
  debug("reading api key from keychain");
  const security = spawn(
    "/usr/bin/security",
    [
      "find-generic-password",
      "-a",
      "AIKIDO_API_KEY",
      "-s",
      "opencode-aikido-mcp",
      "-w",
    ],
    { stdio: ["ignore", "pipe", "inherit"] },
  );

  let output = "";
  security.stdout.on("data", (chunk) => {
    output += chunk.toString("utf8");
  });

  const exitCode = await new Promise((resolve) => {
    security.on("exit", resolve);
  });

  if (exitCode !== 0) {
    debug(`keychain read failed code=${exitCode ?? "null"}`);
    process.exit(exitCode ?? 1);
  }

  debug("keychain read completed");
  return output.trim();
}

function debug(message) {
  appendFileSync(debugLogPath, `${new Date().toISOString()} ${message}\n`);
}
