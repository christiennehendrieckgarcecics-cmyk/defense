<template>
  <div v-if="store.user" class="debug-banner">
    <p>Logged in as: <strong>{{ store.user.email }}</strong></p>
    <p>Role in Store: <span :class="store.user.role === 'admin' ? 'text-lime' : 'text-orange'">"{{ store.user.role }}"</span></p>
    <button @click="manualRedirect" v-if="store.user.role === 'admin'" class="debug-btn">
      Force Go to Admin Page
    </button>
  </div>

  <Navbar />
  
  <router-view />
</template>

<script setup>
import Navbar from './components/Navbar.vue'
import { store } from '@/store.js'
import { useRouter } from 'vue-router'

const router = useRouter()

// This helper lets you manually jump to the admin page if the redirect fails
const manualRedirect = () => {
  router.push('/admin/orders')
}
</script>

<style scoped>
.debug-banner {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 9999;
  background: #222;
  color: #fff;
  padding: 15px;
  border-radius: 12px;
  font-family: monospace;
  font-size: 12px;
  border: 2px solid #8B0000;
  box-shadow: 0 10px 25px rgba(0,0,0,0.5);
}

.text-lime { color: #00ff00; font-weight: bold; }
.text-orange { color: #ff8800; font-weight: bold; }

.debug-btn {
  margin-top: 10px;
  background: #8B0000;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 4px;
  cursor: pointer;
  text-transform: uppercase;
  font-weight: bold;
  font-size: 10px;
}

.debug-btn:hover {
  background: #ff0000;
}
</style>