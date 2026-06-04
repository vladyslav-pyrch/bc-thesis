 const fs = require("fs");
const path = require("path");

function parseColFile(filePath) {
  const content = fs.readFileSync(filePath, "utf8");
  const lines = content.split(/\r?\n/);

  let declaredVertices = null;
  let declaredEdges = null;
  const edges = [];
  let maxVertexSeen = 0;

  for (const [index, rawLine] of lines.entries()) {
    const line = rawLine.trim();

    if (!line || line.startsWith("c")) {
      continue;
    }

    const parts = line.split(/\s+/);
    const recordType = parts[0];

    if (recordType === "p") {
      if (parts.length < 4 || parts[1] !== "edge") {
        throw new Error(`Invalid problem line at ${filePath}:${index + 1}`);
      }

      declaredVertices = Number.parseInt(parts[2], 10);
      declaredEdges = Number.parseInt(parts[3], 10);

      if (!Number.isInteger(declaredVertices) || declaredVertices < 0) {
        throw new Error(`Invalid vertex count at ${filePath}:${index + 1}`);
      }

      if (!Number.isInteger(declaredEdges) || declaredEdges < 0) {
        throw new Error(`Invalid edge count at ${filePath}:${index + 1}`);
      }

      continue;
    }

    if (recordType === "e") {
      if (parts.length < 3) {
        throw new Error(`Invalid edge line at ${filePath}:${index + 1}`);
      }

      const from = Number.parseInt(parts[1], 10);
      const to = Number.parseInt(parts[2], 10);

      if (!Number.isInteger(from) || !Number.isInteger(to)) {
        throw new Error(`Invalid edge vertices at ${filePath}:${index + 1}`);
      }

      if (from === to) {
        throw new Error(`Self-loop found at ${filePath}:${index + 1}`);
      }

      edges.push([from, to]);
      maxVertexSeen = Math.max(maxVertexSeen, from, to);
      continue;
    }

    throw new Error(`Unknown line type "${recordType}" at ${filePath}:${index + 1}`);
  }

  const vertexCount = declaredVertices ?? maxVertexSeen;
  const degrees = Array(vertexCount + 1).fill(0);
  const seenEdges = new Set();

  for (const [from, to] of edges) {
    if (from < 1 || to < 1 || from > vertexCount || to > vertexCount) {
      throw new Error(`Edge (${from}, ${to}) is outside vertex range 1..${vertexCount}`);
    }

    const low = Math.min(from, to);
    const high = Math.max(from, to);
    const key = `${low}:${high}`;

    if (seenEdges.has(key)) {
      continue;
    }

    seenEdges.add(key);
    degrees[from] += 1;
    degrees[to] += 1;
  }

  return {
    declaredVertices,
    declaredEdges,
    vertexCount,
    edgeCount: seenEdges.size,
    maxDegree: Math.max(0, ...degrees),
  };
}

function main() {
  const files = process.argv.slice(2);

  if (files.length === 0) {
    console.error("Usage: node calculate-chromatic.js <graph.col> [more-graphs.col...]");
    process.exit(1);
  }

  const rows = files.map((file) => {
    const filePath = path.resolve(process.cwd(), file);
    const stats = parseColFile(filePath);

    return {
      file,
      vertices: stats.vertexCount,
      edges: stats.edgeCount,
      declaredEdges: stats.declaredEdges ?? "n/a",
      maxDegree: stats.maxDegree,
      chromaticByMaxDegree: stats.maxDegree,
      chromaticByMaxDegreePlusOne: stats.maxDegree + 1,
    };
  });

  console.table(rows);
}

try {
  main();
} catch (error) {
  console.error(error.message);
  process.exit(1);
}
