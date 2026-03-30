import { createApp } from 'vue'
import App from './App.vue'
import router from './router' // Import the router you just created
import './assets/main.css'    // Import your standard CSS

const app = createApp(App)

app.use(router) // Tell Vue to use the router logic

app.mount('#app')