<template>
  <main class="bg-white min-h-screen relative font-sans">
    <div class="border-b border-gray-300">
      <div class="max-w-7xl mx-auto px-4 flex justify-center py-6">
        <h2 class="font-black text-2xl uppercase border-b-[6px] border-black pb-1 tracking-tighter italic">
          Latest sneakers
        </h2>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 pt-12 relative">
      <button 
        @click="goBack" 
        class="absolute left-4 top-1/2 -translate-y-1/2 flex items-center space-x-2 group text-black z-10"
      >
        <span class="text-2xl group-hover:-translate-x-1 transition-transform">←</span>
        <span class="font-black uppercase text-xs tracking-widest border-b-2 border-black">Back to Brands</span>
      </button>

      <div class="flex justify-center">
        <img 
          :src="getBrandLogo($route.params.brandName)" 
          class="h-20 object-contain" 
          :alt="$route.params.brandName" 
        />
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 py-20 flex justify-center">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-x-16 gap-y-20">
        <div 
          v-for="shoe in brandShoes" 
          :key="shoe.name" 
          @click="selectedShoe = shoe" 
          class="flex flex-col items-center group w-64 cursor-pointer"
        >
          <div class="h-64 flex items-center justify-center mb-4 w-full">
            <img 
              :src="getShoeUrl(shoe.fileName)" 
              class="w-full h-full object-contain group-hover:scale-110 transition-transform duration-300" 
            />
          </div>
          <div class="text-center space-y-1">
            <h3 class="font-black uppercase text-[12px] tracking-tight leading-tight w-56 mx-auto">
              {{ shoe.name }}
            </h3>
            <p class="font-black text-[14px]">₱{{ shoe.price }}</p>
            <div class="flex justify-center space-x-3 text-[10px] font-bold text-gray-500 uppercase mt-1">
              <span>{{ shoe.size1 }}</span>
              <span v-if="shoe.size2">{{ shoe.size2 }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="selectedShoe" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
      <div class="bg-white rounded-[50px] shadow-2xl w-full max-w-5xl overflow-hidden relative">
        <button @click="selectedShoe = null" class="absolute top-6 left-10 flex items-center space-x-2 text-black hover:opacity-60 z-20">
          <span class="text-3xl">←</span>
          <span class="font-black uppercase text-sm tracking-tighter">Back to {{ $route.params.brandName }}</span>
        </button>

        <div class="flex flex-col md:flex-row p-12 gap-10">
          <div class="w-full md:w-1/2 border-[4px] border-black p-10 flex flex-col items-center justify-center bg-white rounded-lg">
            <img :src="getShoeUrl(selectedShoe.fileName)" class="w-full h-auto object-contain mb-8" />
            <div class="text-center">
              <h2 class="font-black uppercase text-xl leading-tight mb-2 tracking-tighter">{{ selectedShoe.name }}</h2>
              <p class="font-black text-2xl">₱{{ selectedShoe.price }}</p>
            </div>
          </div>

          <div class="w-full md:w-1/2 bg-[#A3420E] rounded-[50px] p-10 text-white flex flex-col justify-between">
            <div>
              <h2 class="text-5xl font-black italic tracking-tighter mb-8 uppercase">SIZE / S</h2>
              <div class="flex flex-wrap gap-4 mb-10">
                <button 
                  v-for="size in [selectedShoe.size1, selectedShoe.size2, selectedShoe.size3].filter(s => s)" 
                  :key="size"
                  @click="activeSize = size"
                  :class="activeSize === size ? 'bg-black text-white' : 'bg-white text-black'"
                  class="px-6 py-2 rounded-full font-black text-sm border-2 border-black transition-all"
                >
                  {{ size }}
                </button>
              </div>
            </div>
            <button 
              @click="addToCart" 
              class="mt-12 w-full py-4 font-black uppercase text-white bg-transparent border-t-2 border-white/20 hover:bg-white/10 tracking-[0.3em] text-xl"
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
import { ref, computed, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { store } from '@/store.js'; 

const route = useRoute();
const router = useRouter(); 
const selectedShoe = ref(null);
const activeSize = ref('');

const updateStoredBrand = () => {
  if (route.params.brandName) {
    store.lastBrandViewed = route.params.brandName;
  }
};

onMounted(updateStoredBrand);
watch(() => route.params.brandName, updateStoredBrand);

const ALL_BRANDS_DATA = {
  nike: [
    { name: 'Jordan 1 Low "Shattered Blackboard" 2019', price: '4,000.00', size1: '9M/23 CM', size2: '10M/24 CM', size3: '7F/25 CM', fileName: 'shattered-backboard.png' },
    { name: 'Jordan 11 "Space Jam" 2016', price: '13,000.00', size1: '12M/28.6CM', size2: '7T/25.7CM', fileName: 'space-jam.png' },
    { name: 'Jordan 4 "Fire Red" 2020', price: '8,000.00', size1: '7M/25CM', fileName: 'fire-red.png' },
    { name: 'Kobe 8 "Radiant Emerald"', price: '9,000.00', size1: '15M/29.5CM', fileName: 'kobe-emerald.png' }
  ],
  adidas: [
    { name: 'Yeezy 350 V2 "Cloud White"', price: '7,000.00', size1: '5M/24.5CM', size2: '4F/25.8CM', fileName: 'yeezy-cloud.png' },
    { name: 'Samba OG "Cloud White"', price: '3,500.00', size1: '7M/25.4CM', fileName: 'samba.png' },
    { name: 'NMD R1 "OG White"', price: '3,000.00', size1: '12M/28.6CM', size2: '4F/25.8CM', fileName: 'nmd.png' },
    { name: 'Yeezy 500 "Salt"', price: '8,500.00', size1: '7M/25CM', size2: '9F/26.5CM', fileName: 'yeezy-500.png' }
  ],
  puma: [
    { name: 'PUMA COURT CLASSIC DRAGON PATCH', price: '3,500.00', size1: '5M/24.5CM', size2: '12M/29CM', fileName: 'puma-dragon.png' },
    { name: 'PUMA SPEEDCAT BLACK/WHITE', price: '4,500.00', size1: '6.5M/24.5CM', fileName: 'puma-speedcat.png' },
    { name: 'SUEDE CLASSIC XXI', price: '2,500.00', size1: '11M/27.6CM', size2: '4F/25.8CM', fileName: 'suede-pink.png' },
    { name: 'SUEDE CLASSIC BLACK/WHITE', price: '2,500.00', size1: '11M/28CM', fileName: 'suede-black.png' }
  ],
  'new balance': [
    { name: 'NB 2002R "NAVY CASTLEROCK"', price: '3,500.00', size1: '5M/24.5CM', size2: '12M/29CM', fileName: 'nb-2002r-navy.png' },
    { name: 'NB 2002R "GREY POCKET"', price: '4,500.00', size1: '6.5M/24.5CM', fileName: 'nb-2002r-grey.png' },
    { name: 'NB 997H "WHITE GOLD"', price: '2,500.00', size1: '11M/27.6CM', size2: '4F/25.8CM', fileName: 'nb-997-white.png' },
    { name: 'NB 9060 "BEACH GLASS"', price: '2,500.00', size1: '11M/28CM', fileName: 'nb-9060-multi.png' }
  ],
  vans: [
    { name: 'VANS SLIP-ON CHECKERBOARD', price: '2,000.00', size1: '11M/27CM', fileName: 'vans-checkerboard.png' },
    { name: 'AUTHENTIC 44 DX ANAHEIM', price: '2,500.00', size1: '11M/28CM', fileName: 'vans-authentic.png' }
  ],
  asics: [
    { name: 'GEL LYTE 5 "BIRCH"', price: '3,000.00', size1: '5M/24.5CM', size2: '11M/27.6CM', fileName: 'asics-birch.png' },
    { name: 'GEL LYTE 5 "BLUE"', price: '3,500.00', size1: '9M/25CM', fileName: 'asics-blue.png' }
  ]
};

const brandShoes = computed(() => {
  const brand = route.params.brandName.toLowerCase().replace(/%20/g, ' ');
  return ALL_BRANDS_DATA[brand] || [];
});

const goBack = () => router.push('/brands');

const addToCart = () => {
  if (selectedShoe.value) {
    store.add(selectedShoe.value, activeSize.value || selectedShoe.value.size1);
    selectedShoe.value = null;
    activeSize.value = '';
    store.isCartOpen = true;
  }
};

const getBrandLogo = (name) => {
  const brand = name.toLowerCase().replace(/%20/g, ' ');
  const fileName = (brand === 'new balance') ? 'nb' : brand;
  return new URL(`../../brands/${fileName}.png`, import.meta.url).href;
};

const getShoeUrl = (file) => {
  return new URL(`../../latestsneakers/${file}`, import.meta.url).href;
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@900&display=swap');
main { font-family: 'Inter', sans-serif; }
</style>