import { defineConfig } from 'vite';

export default defineConfig({
  publicDir: false, // Disable public dir to avoid conflicts
  build: {
    outDir: 'public',
    emptyOutDir: true,
    rollupOptions: {
      input: {
        main: './src/main.js',
        'main.css': './src/main.css',
      },
      output: {
        entryFileNames: 'assets/[name].js',
        chunkFileNames: 'assets/[name].js',
        assetFileNames: 'assets/[name].[ext]',
      },
    },
  },
  // No dev server needed - we only use Vite for building
});