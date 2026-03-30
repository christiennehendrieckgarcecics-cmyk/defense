<template>
  <div class="min-h-screen bg-white px-6 py-12">
    <div class="max-w-6xl mx-auto flex flex-col items-center">
      
      <div class="grid grid-cols-2 md:grid-cols-4 gap-x-12 gap-y-20 items-center justify-items-center w-full mb-20">
        <div 
          v-for="brand in topRow" 
          :key="brand.name" 
          @click="goToBrand(brand.name)"
          class="flex flex-col items-center group cursor-pointer hover:scale-105 transition-transform duration-300"
        >
          <div class="h-32 flex items-center justify-center mb-4">
            <img 
              :src="brand.img" 
              :alt="brand.name" 
              class="max-w-[180px] max-h-full object-contain grayscale group-hover:grayscale-0 transition-all duration-300" 
            />
          </div>
          <div class="w-16 h-[2px] bg-gray-300 group-hover:bg-[#8B0000] transition-colors"></div>
        </div>
      </div>

      <div class="flex flex-wrap justify-center gap-x-24 gap-y-20 items-center w-full">
        <div 
          v-for="brand in bottomRow" 
          :key="brand.name" 
          @click="goToBrand(brand.name)"
          class="flex flex-col items-center group cursor-pointer hover:scale-105 transition-transform duration-300"
        >
          <div class="h-32 flex items-center justify-center mb-4">
            <img 
              :src="brand.img" 
              :alt="brand.name" 
              class="max-w-[180px] max-h-full object-contain grayscale group-hover:grayscale-0 transition-all duration-300" 
            />
          </div>
          <div class="w-16 h-[2px] bg-gray-300 group-hover:bg-[#8B0000] transition-colors"></div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';
import adidasImg from '../../brands/adidas.png';
import nikeImg from '../../brands/nike.png';
import pumaImg from '../../brands/puma.png';
import nbImg from '../../brands/nb.png';
import vansImg from '../../brands/vans.png';
import asicsImg from '../../brands/asics.png';

const router = useRouter();

// Function to navigate to the Dynamic Route
const goToBrand = (brandName) => {
  // brandName will be 'adidas', 'nike', etc.
  router.push({ name: 'BrandDetail', params: { brandName: brandName } });
};

const topRow = [
  { name: 'adidas', img: adidasImg },
  { name: 'nike', img: nikeImg },
  { name: 'puma', img: pumaImg },
  { name: 'new balance', img: nbImg }
];

const bottomRow = [
  { name: 'vans', img: vansImg },
  { name: 'asics', img: asicsImg }
];
</script>