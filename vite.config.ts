import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*', 'app/frontend/components/**/*.haml'], { delay: 200 }),
    tailwindcss()
  ],
})
