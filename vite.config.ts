import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'
import tailwindcss from '@tailwindcss/vite'
import { readFileSync } from 'fs'
import { resolve } from 'path'

export default defineConfig({
  plugins: [
    svelte(),
    tailwindcss(),
    {
      name: 'static-subpages',
      configureServer(server) {
        server.middlewares.use((req, res, next) => {
          if (req.url === '/date' || req.url === '/date/' || req.url?.startsWith('/date/?')) {
            res.setHeader('Content-Type', 'text/html')
            res.end(readFileSync(resolve(process.cwd(), 'public/date/index.html'), 'utf-8'))
            return
          }
          next()
        })
      },
    },
  ],
})
