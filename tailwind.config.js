/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./templates/**/*.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'primary-blue': '#0056b3',
        'secondary-blue': '#1e6bb8',
        'fifa-red': '#d52b1e',
        'fifa-green': '#009f3d',
        'fifa-gold': '#ffd700',
        'field-green': '#2d8c3c',
        'light-color': '#f8f9fa',
        'dark-color': '#0a1f3a',
        'gray-color': '#6c757d',
        'light-gray': '#e9ecef',
      },
      fontFamily: {
        'bebas': ['Bebas Neue', 'cursive'],
        'montserrat': ['Montserrat', 'sans-serif'],
        'open-sans': ['Open Sans', 'sans-serif'],
      },
      boxShadow: {
        'sporty': '0 6px 20px rgba(0, 86, 179, 0.3)',
      },
      backgroundImage: {
        'sporty-gradient': 'linear-gradient(135deg, var(--primary-blue) 0%, var(--fifa-green) 100%)',
      },
    },
  },
  plugins: [],
  darkMode: 'class',
}