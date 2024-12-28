export async function loadShaderFile(path: string): Promise<string> {
    const response = await fetch(path);
    if (!response.ok) {
      throw new Error(`Failed to load shader at ${path}`);
    }
    return response.text();
  }
  