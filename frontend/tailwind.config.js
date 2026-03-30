/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}", // The "**" means "look in all subfolders" like components/ AND views/
  ],
  theme: {
    extend: {
      colors: {
        brandRed: '#8B0000', // Matches your header color
      }
    },
  },
  plugins: [],
}