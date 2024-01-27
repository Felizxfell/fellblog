/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
  theme: {
    extend: {
      colors: {
        shadow: "#1a1a1a",
        lemon: "#b2e243",
        "green-sheet": "#68d981",
        "green-pistache": "#34d399",
        "blue-sky": "#37d1d9",
        "blue-aqua": "#4ba9fa",
      },
    },
  },
  plugins: [],
};
