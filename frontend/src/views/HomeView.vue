<template>
  <main class="bg-white min-h-screen font-sans">
    <div class="border-b border-gray-300">
      <div class="max-w-7xl mx-auto px-4 py-10 flex justify-center">
        <h2 class="font-black text-4xl uppercase border-b-[8px] border-black pb-2 tracking-tighter italic">
          Latest sneakers
        </h2>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 py-16">
      
      <div v-if="filteredSneakers.length === 0" class="text-center py-20">
        <p class="text-gray-400 font-black uppercase tracking-widest text-xl italic mb-4">
          No matches found for "{{ store.searchQuery }}"
        </p>
        <button 
          @click="store.searchQuery = ''" 
          class="text-black font-black uppercase text-xs underline underline-offset-4 hover:text-orange-600 transition-colors"
        >
          View All Sneakers
        </button>
      </div>

      <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-x-10 gap-y-20">
        <div 
          v-for="shoe in filteredSneakers" 
          :key="shoe.name" 
          @click="selectedShoe = shoe" 
          class="flex flex-col cursor-pointer group"
        >
          <div class="aspect-square w-full flex items-center justify-center mb-6 overflow-hidden bg-[#fcfcfc] rounded-[2.5rem] p-10 transition-all group-hover:bg-[#f4f4f4] border border-transparent group-hover:border-gray-200">
            <img 
              :src="getSneakerUrl(shoe.fileName)" 
              :alt="shoe.name" 
              class="max-w-full max-h-full object-contain transform scale-100 group-hover:scale-110 transition-transform duration-500" 
            />
          </div>
          
          <div class="text-center space-y-1">
            <h3 class="font-black uppercase text-[11px] leading-tight tracking-tight px-4 h-10 flex items-center justify-center">
              {{ shoe.name }}
            </h3>
            
            <p class="font-black text-[18px]">₱{{ shoe.price }}</p>
            
            <div class="flex justify-center items-center space-x-2 pt-2">
              <span class="bg-gray-200 px-3 py-1 rounded-md text-[12px] font-black text-black uppercase tracking-tight">
                {{ shoe.size1 }}
              </span>
              <span v-if="shoe.size2" class="bg-gray-200 px-3 py-1 rounded-md text-[12px] font-black text-black uppercase tracking-tight">
                {{ shoe.size2 }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="selectedShoe" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
      <div class="bg-white rounded-[50px] shadow-2xl w-full max-w-5xl overflow-hidden relative">
        <button @click="selectedShoe = null" class="absolute top-6 left-10 flex items-center space-x-2 text-black hover:opacity-60 z-20">
          <span class="text-3xl">←</span>
          <span class="font-black uppercase text-sm tracking-tighter">Back to Shop</span>
        </button>

        <div class="flex flex-col md:flex-row p-12 gap-10">
          <div class="w-full md:w-1/2 border-[4px] border-black p-10 flex flex-col items-center justify-center bg-white rounded-lg">
            <img :src="getSneakerUrl(selectedShoe.fileName)" class="w-full h-auto object-contain mb-8" />
            <div class="text-center">
              <h2 class="font-black uppercase text-xl leading-tight mb-2 tracking-tighter">{{ selectedShoe.name }}</h2>
              <p class="font-black text-2xl">₱{{ selectedShoe.price }}</p>
            </div>
          </div>

          <div class="w-full md:w-1/2 bg-[#A3420E] rounded-[50px] p-10 text-white flex flex-col justify-between">
            <div>
              <h2 class="text-5xl font-black italic tracking-tighter mb-8 uppercase">Select Size</h2>
              <div class="flex flex-wrap gap-4 mb-10">
                <button 
                  v-for="size in [selectedShoe.size1, selectedShoe.size2, selectedShoe.size3].filter(s => s)" 
                  :key="size"
                  @click="activeSize = size"
                  :class="activeSize === size ? 'bg-black text-white' : 'bg-white text-black'"
                  class="px-8 py-3 rounded-full font-black text-sm border-2 border-black transition-all transform active:scale-95"
                >
                  {{ size }}
                </button>
              </div>
            </div>
            
            <button 
              @click="addToCart" 
              class="mt-12 w-full py-5 font-black uppercase text-white bg-transparent border-t-2 border-white/20 hover:bg-white/10 tracking-[0.3em] text-xl transition-all"
            >
              ADD TO CART
            </button>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup>
import { ref, computed } from 'vue'; // Import computed
import { store } from '@/store.js';

const selectedShoe = ref(null);
const activeSize = ref('');

function getSneakerUrl(fileName) {
  return new URL(`../../latestsneakers/${fileName}`, import.meta.url).href;
}

const literalSneakers = [
  { name: 'Nike Dunk Low "Orange Paisley"', price: '2,500.00', size1: '7M/25CM', size2: '9F/26.5CM', fileName: 'dunk-orange.png' },
  { name: 'Nike Vomero 5 "Platinum Tint"', price: '3,500.00', size1: '10M/27.5CM', size2: '5F/24.5CM', fileName: 'vomero-platinum.png' },
  { name: 'Jordan 1 Low Travis Scott "Black Phantom"', price: '35,000.00', size1: '6M/24.8CM', size2: '4F/25.8CM', fileName: 'jordan-phantom.png' },
  { name: 'Jordan 1 Low Travis Scott "Reverse Mocha"', price: '45,000.00', size1: '7M/25CM', size2: '9F/26.5CM', fileName: 'jordan-mocha.png' }
];

// --- SEARCH FILTER LOGIC ---
const filteredSneakers = computed(() => {
  // If the search bar is empty, show all sneakers
  if (!store.searchQuery || store.searchQuery.trim() === '') {
    return literalSneakers;
  }
  
  // Filter based on the name (making it case-insensitive)
  return literalSneakers.filter(shoe => 
    shoe.name.toLowerCase().includes(store.searchQuery.toLowerCase())
  );
});

const addToCart = () => {
  if (selectedShoe.value) {
    const sizeToBook = activeSize.value || selectedShoe.value.size1;
    store.add(selectedShoe.value, sizeToBook);
    selectedShoe.value = null;
    activeSize.value = '';
    store.isCartOpen = true; 
  }
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@900&display=swap');
main { font-family: 'Inter', sans-serif; }

img {
  backface-visibility: hidden;
  -webkit-font-smoothing: subpixel-antialiased;
}
</style>