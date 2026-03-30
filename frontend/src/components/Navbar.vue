<template>
  <nav class="bg-[#8B0000] text-white p-4 shadow-md sticky top-0 z-[100] font-sans">
    <div class="max-w-7xl mx-auto flex justify-between items-center">
      
      <router-link to="/" class="flex flex-col items-center group">
        <span class="text-3xl font-black italic tracking-tighter leading-none group-hover:text-orange-500 transition-colors">1800</span>
        <span class="text-xs font-bold tracking-[0.3em] uppercase opacity-90 group-hover:text-orange-500 transition-colors">Soles</span>
      </router-link>

      <div class="hidden md:flex space-x-8 font-bold text-sm tracking-widest items-center">
        <router-link to="/" class="hover:text-orange-500 transition-colors" active-class="text-orange-500 underline decoration-2 underline-offset-8">HOME</router-link>
        <router-link to="/brands" class="transition-colors hover:text-orange-500" :class="[isBrandActive ? 'text-orange-500 underline decoration-2 underline-offset-8' : 'text-white']">BRANDS</router-link>
        <router-link to="/about" class="hover:text-orange-500 transition-colors" active-class="text-orange-500 underline decoration-2 underline-offset-8">ABOUT</router-link>
        
        <router-link 
          v-if="store.isLoggedIn" 
          to="/order-history" 
          class="hover:text-orange-500 transition-colors text-orange-400"
          active-class="underline decoration-2 underline-offset-8"
        >
          MY ORDERS
        </router-link>

        <router-link 
          v-if="!store.isLoggedIn" 
          to="/login" 
          class="hover:text-orange-500 transition-colors" 
          active-class="text-orange-500 underline decoration-2 underline-offset-8"
        >
          LOGIN
        </router-link>

        <div v-else class="flex items-center space-x-4 border-l border-white/20 pl-4">
          <span class="text-orange-500 text-[10px] font-black italic uppercase tracking-tighter border border-orange-500 px-2 py-0.5 rounded">
            User: {{ store.user?.username }}
          </span>
          <button @click="handleLogout" class="hover:text-orange-500 transition-colors text-[11px] font-black underline underline-offset-4">
            LOGOUT
          </button>
        </div>
      </div>

      <div class="flex items-center space-x-5">
        <button @click="isChatOpen = !isChatOpen" class="hover:scale-110 transition-transform focus:outline-none">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 10h.01M12 10h.01M16 10h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
          </svg>
        </button>

        <div @click="store.isCartOpen = true" class="relative cursor-pointer hover:scale-110 transition-transform">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
          </svg>
          <span v-if="store.count > 0" class="absolute -top-1 -right-1 bg-orange-600 text-[10px] rounded-full px-1.5 py-0.5 font-black shadow-sm">
            {{ store.count }}
          </span>
        </div>

        <div class="relative hidden sm:block">
          <input type="text" class="bg-white text-black px-3 py-1 pr-10 rounded-sm text-sm outline-none w-48 lg:w-64 border-none" placeholder="Search..."/>
          <button class="absolute right-2 top-1/2 -translate-y-1/2 text-gray-800">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </button>
        </div>
      </div>
    </div>

    <div v-if="isChatOpen" class="fixed top-20 right-4 z-[250] w-[350px] animate-in fade-in zoom-in duration-200">
      <div class="bg-black rounded-[2.5rem] overflow-hidden shadow-2xl border-4 border-black">
        <div class="p-4 text-center">
          <h3 class="text-white font-black uppercase tracking-tighter text-xl">Chat with an admin</h3>
        </div>
        <div class="bg-white mx-2 mb-2 rounded-[2rem] h-[350px] flex flex-col p-4 relative">
          <div class="mt-auto mb-4 flex flex-col items-start">
            <div class="border-2 border-black rounded-full px-4 py-2 text-black font-bold text-sm">
              How can I help you?
            </div>
          </div>
          <div class="relative">
            <input 
              type="text" 
              placeholder="Enter a text"
              class="w-full border-2 border-black rounded-full px-4 py-2 text-sm text-black placeholder-gray-500 focus:outline-none"
            />
          </div>
        </div>
      </div>
    </div>

    <div v-if="store.isCartOpen" class="fixed inset-0 z-[200] bg-[#A3420E] flex flex-col items-center p-8 overflow-y-auto font-sans">
      <div class="w-full max-w-2xl relative">
        <div class="flex justify-between items-end mb-8">
          <h2 class="text-white text-6xl font-black italic uppercase tracking-tighter">My Cart</h2>
        </div>

        <div class="space-y-4 mb-8">
          <div v-if="store.cart.length === 0" class="text-white font-bold text-center py-10 opacity-60 uppercase tracking-widest">
            Your cart is empty
          </div>
          <div v-for="(item, index) in store.cart" :key="index" class="bg-white rounded-[40px] p-6 flex items-center relative shadow-lg">
            <button @click="store.remove(index)" class="absolute top-4 right-6 text-gray-300 text-3xl hover:text-red-500">&times;</button>
            <div class="w-1/3 flex justify-center">
              <img :src="getShoeUrl(item.fileName)" class="h-24 object-contain" />
            </div>
            <div class="w-2/3 pr-8">
              <h3 class="font-black text-black uppercase text-[13px] tracking-tighter mb-1">{{ item.name }}</h3>
              <p class="font-black text-black text-xl mb-1">₱{{ item.price }}</p>
              <div class="border-t border-gray-200 pt-1 mt-1">
                <p class="text-gray-400 font-bold text-[10px] uppercase">{{ item.selectedSize }}</p>
              </div>
            </div>
          </div>
        </div>

        <button @click="addMore" class="w-full bg-white rounded-full py-4 mb-6 font-black uppercase tracking-[0.3em] text-black text-xl shadow-lg hover:bg-gray-100">
          Add More
        </button>

        <div class="bg-white rounded-[45px] p-8 shadow-xl">
          <h3 class="text-4xl text-black font-black uppercase mb-8 italic">Total: ₱{{ store.total }}</h3>
          <div class="flex justify-end">
            <button 
              @click="goToCheckout"
              class="bg-[#A3420E] text-white px-10 py-3 rounded-full font-black uppercase text-lg hover:scale-105 transition-transform"
            >
              {{ store.isLoggedIn ? 'Complete Purchase' : 'Checkout' }} ({{ store.count }})
            </button>
          </div>
        </div>
        
        <button @click="store.isCartOpen = false" class="mt-8 w-full text-center text-white/50 uppercase font-black tracking-widest text-xs hover:text-white">
          Close Cart
        </button>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { store } from '@/store.js';

const route = useRoute();
const router = useRouter();
const isChatOpen = ref(false);

const isBrandActive = computed(() => route.path.startsWith('/brands'));

const getShoeUrl = (file) => {
  return new URL(`../../latestsneakers/${file}`, import.meta.url).href;
};

const goToCheckout = () => {
  store.isCartOpen = false;
  if (store.isLoggedIn) {
    router.push('/checkout');
  } else {
    router.push('/login');
  }
};

const addMore = () => {
  store.isCartOpen = false;
  if (store.lastBrandViewed) {
    router.push(`/brands/${store.lastBrandViewed}`);
  } else {
    router.push('/brands');
  }
};

const handleLogout = () => {
  store.logout();
  router.push('/');
};
</script>

<style scoped>
h3 {
  font-family: 'Arial Black', 'Gadget', sans-serif;
}
</style>