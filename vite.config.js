import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import jsconfigPaths from 'vite-jsconfig-paths'


// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), jsconfigPaths()],
  server: {
    host: true,
    port: 3000,
    strictPort: true,
    //origin: "http: //0.0.0.0:8080",
  },
  build: {
    rollupOptions: {
      external: [
        '@assets/icons/roomBooking.svg',
        '@assets/icons/multipleroomBooking.svg',
        '@assets/commonData/DashboardData',
      ],
    },
  },
})
